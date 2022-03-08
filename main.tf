# ===================================================================
# Main Terraform File
# This file contains all the assicated blocks related to infrastructure
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
      source  = "hashicorp/google"
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

# GCP Bucket for mCV site
resource "google_storage_bucket" "myCV" {
  name          = "martinrusak.ca"
  location      = "northamerica-northeast2"
  force_destroy = true

  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
  }
}

# GCP IAM policy for public access
data "google_iam_policy" "viewer" {
  binding {
    role = "roles/storage.objectViewer"
    members = [
      "allUsers",
    ]
  }
}

resource "google_storage_bucket_iam_policy" "policy" {
  bucket      = google_storage_bucket.myCV.name
  policy_data = data.google_iam_policy.viewer.policy_data
}

# ===================================================================
# Web Site Content
# ===================================================================
# Loop through all files
resource "google_storage_bucket_object" "myFiles" {
  count        = length(var.files)
  name         = element(var.files, count.index)
  content_type = element(var.file_types, count.index)
  source       = element(var.files, count.index)
  bucket       = google_storage_bucket.myCV.name
}


