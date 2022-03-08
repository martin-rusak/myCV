# ===================================================================
# Networking Terraform File
# This file contains all the assicated blocks related to networking
# ===================================================================
# Reserve an external IP
resource "google_compute_global_address" "myCV" {
  name = "website-lb-ip"
}

# Set the managed DNS zone
data "google_dns_managed_zone" "gcp_myCV" {
  name = "martinrusak"
}

# Add the IP to the DNS
resource "google_dns_record_set" "myCV" {
  name         = "www.${data.google_dns_managed_zone.gcp_myCV.dns_name}"
  type         = "A"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.gcp_myCV.name
  rrdatas      = [google_compute_global_address.myCV.address]
}

# Add the bucket as a CDN backend
resource "google_compute_backend_bucket" "myCV" {
  name        = "website-backend"
  description = "Contains files needed by the website"
  bucket_name = google_storage_bucket.myCV.name
  enable_cdn  = true
}

# Create HTTPS certificate
resource "google_compute_managed_ssl_certificate" "mycert" {
  name = "mycv-cert"
  managed {
    domains = [google_dns_record_set.myCV.name]
  }
}

# GCP URL MAP
resource "google_compute_url_map" "myCV" {
  name            = "mycv-url-map"
  default_service = google_compute_backend_bucket.myCV.self_link
}

# GCP target proxy 443
resource "google_compute_target_https_proxy" "myCV" {
  name             = "mycv-target-proxy"
  url_map          = google_compute_url_map.myCV.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.mycert.self_link]
}

# GCP target proxy 80
resource "google_compute_target_http_proxy" "myCV" {
  name    = "mycv-target-proxy-80"
  url_map = google_compute_url_map.myCV.self_link
}

#GCP forwarding rule 443
resource "google_compute_global_forwarding_rule" "default" {
  name                  = "mycv-forwarding-rule"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = google_compute_global_address.myCV.address
  ip_protocol           = "TCP"
  port_range            = "443"
  target                = google_compute_target_https_proxy.myCV.self_link
}

#GCP forwarding rule 80
resource "google_compute_global_forwarding_rule" "default80" {
  name                  = "mycv-forwarding-rule-80"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = google_compute_global_address.myCV.address
  ip_protocol           = "TCP"
  port_range            = "80"
  target                = google_compute_target_http_proxy.myCV.self_link
}
