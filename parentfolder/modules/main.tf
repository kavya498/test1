module "vpc" {
  source = "../test"
  name   = var.name
}

terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
    }
  }
}

provider "ibm" {
  ibmcloud_api_key = var.key
}

variable "key" {

}
variable "name" {

}