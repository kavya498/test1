variable "ic_api_key"{}

provider "ibm"{
    region="eu-de"
  ibmcloud_api_key=var.ic_api_key
}
resource "random_string" "name" {
  length  = 8
  upper   = false
  lower   = true
  number  = false
  special = false
}

resource "ibm_database" "database" {
  name              = random_string.name.id
  plan              = "standard"
  location          = "eu-de"
  service           = "databases-for-etcd"
}
