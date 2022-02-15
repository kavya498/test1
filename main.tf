provider "ibm" {
    region = "eu-de"
}
terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
	  version = "1.38.2"
    }
  }
}


resource "ibm_database" elastic {
  name              = "es"
  plan              = "standard"
  location          = "eu-de"
  service           = "databases-for-elasticsearch"
  resource_group_id = "766f3584b2c840ee96d856bc04551da8"
  // Must Be an Increment of 384
  members_memory_allocation_mb = 18048
  // Must be an Increment of 3072
  members_disk_allocation_mb   = 451584
  adminpassword = "kavya12345"
  key_protect_key = "crn:v1:bluemix:public:kms:us-south:a/4448261269a14562b839e0a3019ed980:adb92f84-eb19-4b6b-8afd-c496af08f7ba:key:d7ad00ed-9da3-4b4c-aea0-3fb71c1b8acc"
  key_protect_instance = "crn:v1:bluemix:public:kms:us-south:a/4448261269a14562b839e0a3019ed980:adb92f84-eb19-4b6b-8afd-c496af08f7ba::"
}
