
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
}

variable "resource_group_name" {
  description = "Where to create resources"
}
