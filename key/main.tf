
terraform {
  required_providers {
    //kubernetes = "= 2.3.2"
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.41.0"
    }
  }
}

# data "ibm_container_cluster_config" "cluster_config" {
#   cluster_name_id = "c786rsbf06b9qk9g1dv0"
#   admin           = true
# }
provider "kubernetes" {
  #load_config_file       = "false"
  #config_path = data.ibm_container_cluster_config.cluster_config.config_file_path
  #host                   = data.ibm_container_cluster_config.cluster_config.host
  #token                  = data.ibm_container_cluster_config.cluster_config.token
  #cluster_ca_certificate = data.ibm_container_cluster_config.cluster_config.ca_certificate
  host                   = data.ibm_container_cluster_config.cluster_config.host
  client_certificate     = data.ibm_container_cluster_config.cluster_config.admin_certificate
  client_key             = data.ibm_container_cluster_config.cluster_config.admin_key
  cluster_ca_certificate = data.ibm_container_cluster_config.cluster_config.ca_certificate

}
provider ibm {
  ibmcloud_api_key=var.key
}
variable key {
}

resource "ibm_resource_instance" "instance" {
  name              = "test1"
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  tags = [
    "applicationname:k8s-module",
    "environmentid:local",
    "environmenttype:int",
    "project:starterkit-k8s-module"
  ]
}

resource "ibm_resource_key" "resourceKey" {
  name                 = "testkey1"
  role                 = "Writer"
  resource_instance_id = ibm_resource_instance.instance.id
  parameters = {
    "HMAC" = true
  }
}

resource "ibm_resource_key" "resourceKeyadmin" {
  name                 = "testkey2"
  role                 = "Manager"
  resource_instance_id = ibm_resource_instance.instance.id
   parameters = {
    "HMAC" = true
  }
}

# Secret
# resource "kubernetes_secret" "config-secret-vol" {
#  depends_on = [ibm_resource_instance.instance, ibm_resource_key.resourceKey]
#   metadata {
#     name      = "test2"
#     namespace = "default"
#   }
#   immutable = true
#   data = {
#      #endpoint = var.cosvol_endpoint
#      #service-instance-id = element(split(":",ibm_resource_instance.namespacek8s_cosvol.id),7)
#      #api-key = "${ ibm_resource_key.resourceKey.credentials["apikey"]}"
#      access-key = ibm_resource_key.resourceKey.credentials["cos_hmac_keys.access_key_id"]
#      secret-key = ibm_resource_key.resourceKey.credentials["cos_hmac_keys.secret_access_key"]
#      res-conf-apikey = ibm_resource_key.resourceKeyadmin.credentials["apikey"]
#      date = timestamp()
#   }
#   type = "ibm/ibmc-s3fs"
# }


output "access-key" { 
value = ibm_resource_key.resourceKey.credentials["cos_hmac_keys.access_key_id"]
sensitive = true
}
output "secret-key" { 
value = ibm_resource_key.resourceKey.credentials["cos_hmac_keys.secret_access_key"]
sensitive = true
}

output "res-conf-apikey" { 
value = ibm_resource_key.resourceKeyadmin.credentials["apikey"]
sensitive = true
}


/*data "ibm_container_cluster_config" "mycluster" {
  cluster_name_id = "bs7forfd0i9idb52dcs0"
  resource_group_id = data.ibm_resource_group.group.id
}

# provider "kubernetes" {
#   load_config_file       = "false"
#   host                   = data.ibm_container_cluster_config.mycluster.host
#   token                  = data.ibm_container_cluster_config.mycluster.token
#   cluster_ca_certificate = data.ibm_container_cluster_config.mycluster.ca_certificate
# }

# resource "kubernetes_secret" "appsecrets" {
#   metadata {
#     name = "my-credentials"
#     namespace = "default"
#   }

#   data = {
#     cos_apiKey             = ibm_resource_key.resourceKey.credentials.apikey
#     cos_resourceInstanceId = ibm_resource_key.resourceKey.credentials.resource_instance_id
#     cos_access_key_id      = ibm_resource_key.resourceKey.credentials["cos_hmac_keys.access_key_id"]
#     cos_secret_access_key  = ibm_resource_key.resourceKey.credentials["cos_hmac_keys.secret_access_key"]
#   }
# }
data "ibm_resource_key" "keydata" {
depends_on = ["ibm_resource_key.resourceKey"] 
name = "testkey"
 resource_instance_id = "${ibm_resource_instance.instance.id}"
}

resource "ibm_cos_bucket" "bucket" {
  bucket_name           = "testmyrinitestnew"
  resource_instance_id  = "${ibm_resource_instance.instance.id}"
  cross_region_location = "us"
  storage_class         = "standard"
}*/
