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
data "ibm_resource_group" "group" {
  name = "pte-interns"
}
resource "ibm_database" "icd_mongo" {
  name              = "mongo"
  service           = "databases-for-mongodb"
  plan              = "standard"
  version           = "4.2"
  resource_group_id            = data.ibm_resource_group.group.id
  location          = "eu-de"
  adminpassword                = "Passw0rd01"
  members_memory_allocation_mb = 3072  # 1GB  per member
  members_disk_allocation_mb   = 61440 # 20GB per member
}
resource "ibm_database" "icd_mongo1" {
  depends_on =[ibm_database.icd_mongo]
  name              = "mongo1"
  service           = "databases-for-mongodb"
  plan              = "standard"
  version           = "4.2"
  resource_group_id            = data.ibm_resource_group.group.id
  location          = "eu-de"
  adminpassword                = "Passw0rd01"
  members_memory_allocation_mb = 3072  # 1GB  per member
  members_disk_allocation_mb   = 61440 # 20GB per member
}
resource "ibm_database" "icd_mongo2" {
	depends_on =[ibm_database.icd_mongo1]
  name              = "mongo2"
  service           = "databases-for-mongodb"
  resource_group_id            = data.ibm_resource_group.group.id
  plan              = "standard"
  version           = "4.2"
  location          = "eu-de"
  adminpassword                = "Passw0rd01"
  members_memory_allocation_mb = 3072  # 1GB  per member
  members_disk_allocation_mb   = 61440 # 20GB per member
}
resource "null_resource" "sleep" {
	depends_on =[ibm_database.icd_mongo2]

  provisioner "local-exec" {
    command = "sleep 60m"
  }
}
