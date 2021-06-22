provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
  credentials = var.gcp_credentials
}
data "google_compute_zones" "available" {
  project = var.gcp_project
  region  = var.gcp_region
}
variable "gcp_project" {
  description = "GCP Project ID"
  type        = string
}
variable "gcp_region" {
  description = "Google Region"
  type        = string
}
variable "gcp_credentials" {
  description ="Either the path to or the contents of a service account key file in JSON format."
  type =string
}
