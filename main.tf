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

resource "ibm_database" "icd_mongo" {
  name              = "mongo"
  service           = "databases-for-mongodb"
  plan              = "standard"
  version           = "4.2"
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
  location          = "eu-de"
  adminpassword                = "Passw0rd01"
  members_memory_allocation_mb = 3072  # 1GB  per member
  members_disk_allocation_mb   = 61440 # 20GB per member
}
resource "ibm_database" "icd_mongo2" {
	depends_on =[ibm_database.icd_mongo1]
  name              = "mongo2"
  service           = "databases-for-mongodb"
  plan              = "standard"
  version           = "4.2"
  location          = "eu-de"
  adminpassword                = "Passw0rd01"
  members_memory_allocation_mb = 3072  # 1GB  per member
  members_disk_allocation_mb   = 61440 # 20GB per member
}
