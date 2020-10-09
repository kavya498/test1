variable "ic_api_key"{}

provider "ibm"{
    region="eu-de"
  ibmcloud_api_key=var.ic_api_key
}
data "ibm_resource_group" "test_acc" {
	name = "Default"
}
resource "ibm_database" "rabit" {
    resource_group_id = data.ibm_resource_group.test_acc.id
    name              = "rabbit-test-db"
    service           = "messages-for-rabbitmq"
    plan              = "standard"
    location          = "eu-de"
    adminpassword                = "password12"
    members_memory_allocation_mb = 6144
    members_disk_allocation_mb   = 6144
    users {
        name     = "user123"
        password = "password12"
    }
    whitelist {
        address     = "172.168.1.2/32"
        description = "desc1"
    }
}
