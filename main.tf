terraform {
  required_version = ">=0.13"
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    ibm = {
      source = "ibm-cloud/ibm"
    }
  }
}
provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
  credentials = var.gcp_credentials
}
provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
}
variable "ibmcloud_api_key"{}

data "ibm_resource_group" "rg"{
  name= "Default"
}
data "google_compute_zones" "available" {
  project = var.gcp_project
  region  = var.gcp_region
}
output "zone" {
  value = data.google_compute_zones.available
}
output "rg" {
  value = data.ibm_resource_group.rg
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
