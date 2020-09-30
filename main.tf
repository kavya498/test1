variable "ic_api_key"{}
# variable "name"{}
provider "ibm"{
  ibmcloud_api_key=var.ic_api_key
}
data "ibm_container_cluster_config" "cluster_config" {
    cluster_name_id  = "btplfs0d0noh9gcrniog"
   resource_group_id ="Default"
}
