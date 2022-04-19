data "ibm_resource_group" "group" {
  name = var.resource_group_name
}

resource "ibm_is_vpc" "vpc" {
  name           = var.vpc_name
  resource_group = data.ibm_resource_group.group.id
  tags = ["tag1","tag2"]
}

terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
    }
  }
}

provider "ibm" {
  region = var.region
  ibmcloud_api_key = var.key
}

variable "key" {
  description = "IBM Cloud Platform API Key"
}

variable "resource_group_name" {
  description = "Where to create resources"
  default = "Default"
}

variable "vpc_name" {
  default = "harini-test-vpc"
}
variable "region" {
  default = "us-south"
}
