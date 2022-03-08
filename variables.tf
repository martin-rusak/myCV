# ===================================================================
# Variables Terraform File
# This file contains all the assicated variables related to all components
# ===================================================================
# GCP Project ID
variable "GCPproject" {
  default = "mycv-343118"
}

# GCP PRegion
variable "GCPregion" {
  default = "northamerica-northeast2"
}

# GCP Zone
variable "GCPzone" {
  default = "northamerica-northeast2-a"
}

variable "files" {
  description = "A list of all folders in main bucket. Use the format [mean folder]/[sub folder]/, with the different folders separated with a comma."

  default = [
    "index.html",
    "css/style.css",
    "js/functions.js",
    "images/me.gif",
    "images/d+h.jpg",
    "images/ifds.png",
    "images/mlf.png",
    "images/ssnc.png",
    "images/tabler-icon-brand-github.png",
    "images/tabler-icon-brand-linkedin.png",
    "images/tabler-icon-mail.png",
    "images/tabler-icon-map-pin.png"
  ]
}
variable "file_types" {
  description = "A list of all file types"

  default = [
    "text/html",
    "text/css",
    "text/javascript",
    "image/gif",
    "image/jpeg",
    "image/png",
    "image/png",
    "image/png",
    "image/png",
    "image/png",
    "image/png",
    "image/png"
  ]
}