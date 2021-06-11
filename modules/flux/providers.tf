terraform {
  required_providers {
    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = ">= 2.0.2"
    # }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.20.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.0.13"
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "flux" {}
