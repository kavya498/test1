#########################################################################################
# IBM Cloud Key Management Services Provisioning and Managing Keys
# Copyright 2021 IBM
#########################################################################################
provider "ibm"{
ibmcloud_api_key=var.ibmcloud_api_key
}
terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.25.0"
    }
  }
}
data "ibm_resource_group" "resource_group" {
  name = "default"
}
data "ibm_container_cluster_config" "config" {
  cluster_name_id = "c27p2ahw01r2v51o295g"
  resource_group_id = data.ibm_resource_group.resource_group.id
}
output "config"{
  value = data.ibm_container_cluster_config.config
}
resource "null_resource" "install_openshift_pipelines_rh_operator" {
  provisioner "local-exec" {
    environment={
      KUBECONFIG     =  data.ibm_container_cluster_config.config.config_file_path
      OPERATOR_NAME  = "kiali-ossm"
      OPERATOR_CHANNEL = "stable"
    }
    command = <<EOF
    echo $KUBECONFIG
    cat $KUBECONFIG
    oc get service
EOF
  }
}
