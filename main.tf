# ===================================================================
# Main Terraform File
# This file contains all the assicated blocks related to infrastructure
# ===================================================================
# ===================================================================
# Provider Terraform File
# This file contains all the assicated blocks related to providers
# ===================================================================
terraform {
    backend "remote" {
    # Terraform Cloud Config  
    organization = "Rusakmedia"
    workspaces {
      name = "myCV"
    }
  }
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.10.0"
    }
  }
}

# ===================================================================
# GCP Provider
# ===================================================================
provider "google" {
  credentials = file("${path.module}/CredFiles/mycv-svc-creds.json")
  project     = var.GCPproject
  region      = var.GCPregion
  zone        = var.GCPzone
}