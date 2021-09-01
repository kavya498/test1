terraform {
  required_providers {
    ibm = {
      source = "ibm-cloud/ibm"
      version = "~> 1.26.0"
    }
  }
}
provider "ibm" {
    ibmcloud_api_key = var.ibmcloud_api_key
}
variable "ibmcloud_api_key" {}
data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = "c2047t5d0hfu7oe0emm0"
  admin           = true
}


provider "kubernetes" {
  host                   = data.ibm_container_cluster_config.cluster_config.host
  client_certificate     = data.ibm_container_cluster_config.cluster_config.admin_certificate
  client_key             = data.ibm_container_cluster_config.cluster_config.admin_key
  cluster_ca_certificate = data.ibm_container_cluster_config.cluster_config.ca_certificate
}


resource "kubernetes_namespace" "namespacek8s" {
  metadata {
    labels = {
      namespace_name = "test"
    }
    name = "test"
  }
}
