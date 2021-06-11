# Needs flux.tf already deployed
# Generate manifests
data "flux_sync" "main" {
  name               = var.flux_resource_name
  count              = var.flux_applied
  target_path        = var.target_path
  url                = var.url
  branch             = var.branch_name
  namespace          = var.flux_namespace
  interval           = var.sync_interval
  git_implementation = "libgit2"
  secret             = var.flux_secret_name
}

# Split multi-doc YAML with
# https://registry.terraform.io/providers/gavinbunney/kubectl/latest
data "kubectl_file_documents" "sync" {
  content = data.flux_sync.main[0].content
}

# Convert documents list to include parsed yaml data
locals {
  sync = [for v in data.kubectl_file_documents.sync.documents : {
    data : yamldecode(v)
    content : v
    }
  ]
}

# Apply manifests on the cluster
resource "kubectl_manifest" "sync" {
  for_each = { for v in local.sync : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  depends_on = [
  data.kubectl_file_documents.sync]
  yaml_body = each.value
}

resource "tls_private_key" "flux_secret" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


# Generate a Kubernetes secret with the Git credentials
resource "kubernetes_secret" "main" {

  metadata {
    name      = data.flux_sync.main[0].secret
    namespace = data.flux_sync.main[0].namespace
  }

  data = {
    known_hosts    = var.known_hosts
    identity       = tls_private_key.flux_secret.private_key_pem
    "identity.pub" = tls_private_key.flux_secret.public_key_pem
  }
}

output "public_key_openssh" {
  value = tls_private_key.flux_secret.public_key_openssh
}
