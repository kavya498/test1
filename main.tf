provider "ibm" {
    region = "eu-de"
	ibmcloud_api_key      = var.ibmcloud_api_key
}
terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"

    }
  }
}
variable ibmcloud_api_key {
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
  type        = string
}
resource "ibm_is_vpc" "example" {
  name = "example-vpc"
}
