variable "ic_api_key"{}
variable "resource_group"{}
provider "ibm"{
  ibmcloud_api_key=var.ic_api_key
}
data "ibm_resource_group" "resource_group" {
  name = var.resource_group
}
data "ibm_container_cluster_config" "cluster_config" {
    cluster_name_id  = "btplfs0d0noh9gcrniog"
    resource_group_id = data.ibm_resource_group.resource_group.id
    config_dir = "/tmp"
}
