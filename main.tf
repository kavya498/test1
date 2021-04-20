#########################################################################################
# IBM Cloud Key Management Services Provisioning and Managing Keys
# Copyright 2021 IBM
#########################################################################################
data "ibm_resource_group" "resource_group" {
  name = var.resource_group
}

module "kms_instance" {
  source                 = "./modules/instance"
  resource_group_id      = data.ibm_resource_group.resource_group.id
  service_name           = var.service_name
  location               = var.location
  plan                   = "tiered-pricing"
  tags                   = var.tags
  allowed_network_policy = var.allowed_network_policy
}

output "rg" {
  value = module.kms_key.data.ibm_resource_group.resource_group
}
