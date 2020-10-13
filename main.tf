variable "ic_api_key"{}

provider "ibm"{
    region="eu-de"
  ibmcloud_api_key=var.ic_api_key
}
data "ibm_resource_group" "test_acc" {
	name = "Default"
}
resource "ibm_database" "redis_standard" {
    name              = "rabbit-backup"
    service           = "messages-for-rabbitmq"
    plan              = "standard"
    location          = "eu-de"
    backup_id           = "crn:v1:bluemix:public:messages-for-rabbitmq:eu-de:a/4448261269a14562b839e0a3019ed980:ba99078e-cf2c-4727-9a7f-bbb91d131fe8::"
    service_endpoints   = "private"
    resource_group_id   = data.ibm_resource_group.test_acc.id
    tags = ["oss","terraform","redis_standard"]
    members_memory_allocation_mb = 4096
    members_disk_allocation_mb   = 2048
}
