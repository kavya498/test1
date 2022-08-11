
terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
    }
  }
}
data "ibm_resource_group" "group" {
  name = var.resource_group_name
}

provider "ibm" {
  ibmcloud_api_key = var.key
}

variable "key" {
  description = "IBM Cloud Platform API Key"
}

variable "resource_group_name" {
  description = "Where to create resources"
  default = "Default"
}
