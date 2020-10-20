variable "ic_api_key"{}

provider "ibm"{
    region="eu-de"
  ibmcloud_api_key=var.ic_api_key
}
data "ibm_resource_group" "test_acc"{
    name ="Default"
}

resource "ibm_resource_instance" "cos_instance" {
  name              = "cos-instance-sch"
  resource_group_id = data.ibm_resource_group.test_acc.id
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  tags = concat(var.database_tags, list("GIT_VERSION:1.0"))
    parameters = {
    "HMAC" = true
    }
    timeouts {
        create = "25m"
        update = "15m"
        delete = "15m"
    }
}

resource "ibm_database" "pg" {
    resource_group_id = data.ibm_resource_group.test_acc.id
    name              = "pg-test-schematics"
    service           = var.database_type
    plan              = "standard"
    location          = "eu-de"
    service_endpoints= var.service_end_points
    version= var.database_version
    adminpassword                = var.admin_password
    members_memory_allocation_mb = var.ram_size
    members_disk_allocation_mb   = var.disk_size
    tags = concat(var.database_tags, list("GIT_VERSION:1.0"))
    timeouts {
        create = "120m"
        update = "60m"
        delete = "15m"
    }
}
