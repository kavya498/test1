resource "ibm_is_vpc" "test" {
  name = var.name
}


terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
    }
  }
}

variable "name" {

}