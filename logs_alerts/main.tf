data "ibm_logs_alert_definitions" "logs_alert_definitions" {
  instance_id = "dd3a5761-a991-4778-aa6c-14658035d24d"
  region      = "eu-fr2"
  endpoint_type = "private"
}
provider "ibm" {
  region           = "eu-fr2"
  ibmcloud_api_key = var.ibmcloud_api_key
  visibility= "private"
}
variable "ibmcloud_api_key" {

}
terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.86.1"
    }
  }
}
