terraform {
  required_providers {
    ibm = {
      source = "ibm-cloud/ibm"
    }
  }
}
provider "ibm" {
    ibmcloud_api_key = var.ibmcloud_api_key
}
variable "ibmcloud_api_key" {}

resource "ibm_resource_group" "resource_group" {
	name ="vpc-cluster"
}
resource "ibm_is_vpc" "vpc" {
	name = "vpc-cluster"
  resource_group = ibm_resource_group.resource_group.id
}
resource "ibm_is_subnet" "subnet" {
	name                     = "vpc-cluster"
	vpc                      = ibm_is_vpc.vpc.id
	zone                     = "us-south-1"
	total_ipv4_address_count = 256
  resource_group = ibm_resource_group.resource_group.id
}

resource "ibm_container_vpc_cluster" "cluster" {
	name              = "vpc-cluster"
	vpc_id            = ibm_is_vpc.vpc.id
	flavor            = "cx2.2x4"
	worker_count      = 1
  resource_group_id = ibm_resource_group.resource_group.id
	zones {
		 subnet_id = ibm_is_subnet.subnet.id
		 name      = "us-south-1"
	}
  }
