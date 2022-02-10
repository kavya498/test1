resource "ibm_database" "icd_mongo" {
  name              = "mongo-stage"
  service           = "databases-for-mongodb"
  plan              = "standard"
  version           = "4.2"
  location          = "eu-de"
#   tags              = var.tags
  adminpassword                = "Passw0rd01"
  members_memory_allocation_mb = 3072  # 1GB  per member
  members_disk_allocation_mb   = 61440 # 20GB per member
  members_cpu_allocation_count = 0
}
provider "ibm"{
    region = "eu-de"
}
