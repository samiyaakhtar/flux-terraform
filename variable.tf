variable "target_path" {
  type        = string
  description = "Relative path to the Git repository root where the sync manifests are committed."
}

variable "url" {
  type        = string
  description = "URL of the manifest git repository"
}

variable "branch_name" {
  type        = string
  description = "Branch name of the git branch to sync to"
}

variable "sync_interval" {
  type        = string
  default     = 1
  description = "Sync interval in minutes"
}

variable "flux_secret_name" {
  type        = string
  default     = "flux-secret"
  description = "Name of the flux secret"
}

variable "known_hosts" {
  type        = string
  description = "Known hosts for SSH authentication"
}

variable "flux_namespace" {
  type        = string
  default     = "flux-system"
  description = "Name of the flux namespace"
}

variable "flux_resource_name" {
  type        = string
  default     = "flux-source"
  description = "Unique name for the flux resource"
}



