# ===================================================================
# Variables Terraform File
# This file contains all the assicated variables related to all components
# ===================================================================
# GCP Project ID
variable "GCPproject" {
  default = "red-airline-340916"
}

# GCP PRegion
variable "GCPregion" {
  default = "northamerica-northeast2"
}

# GCP Zone
variable "GCPzone" {
  default = "northamerica-northeast2-a"
}