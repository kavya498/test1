
variable "database_name" {
type = "string"
default = "schematics-postgres-test99"
}
variable "database_location" {
type = "string"
default = "eu-de"
}
variable "database_plan" {
type = "string"
default = "standard"
}
variable "resource_group" {
type = "string"
default = "BNPP_CloudNG"
}
variable "service_end_points" {
type="string"
default="private"
}
variable "database_version" {
type="string"
default="11"
}
variable "cpu_size" {
type="string"
default = "6"
}
variable "ram_size" {
type = "string"
default = "2048"
}
variable "disk_size" {
type = "string"
default = "10240"
}
variable "admin_password" {
type = "string"
default = "Admin@123456"
}
variable "backup_id" {
type = "string"
default = "no"
}
variable "database_type" {
type = "string"
default = "databases-for-postgresql"
}
variable "database_tags" {
type = "list"
default = ["key1:tag1", "key2:tag2", "key3:tag3"]
}
variable "git_version" {
type = "string"
default = "1.0"
}
variable "whitelisting" {
default = []
}
