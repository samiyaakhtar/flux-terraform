module "flux" {
  source         = "./modules/flux"
  target_path    = var.target_path
  flux_namespace = var.flux_namespace
}

module "sync" {
  source             = "./modules/sync"
  flux_applied       = module.flux.flux_applied
  flux_resource_name = var.flux_resource_name
  target_path        = var.target_path
  url                = var.url
  branch_name        = var.branch_name
  sync_interval      = var.sync_interval
  flux_secret_name   = var.flux_secret_name
  flux_namespace     = var.flux_namespace
  known_hosts        = var.known_hosts
}

output "public_key_openssh" {
  value = module.sync.public_key_openssh
}
