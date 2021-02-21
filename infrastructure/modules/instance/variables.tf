# Common.

variable "tags" {
  type = map
}

# Instance.
variable "instance_type" {
  description = "Type of instance used."
  default     = "t3.micro"
}

variable "ami_id" {
  description = "ID of AMI to use."
  default     = "ami-0dd90801535a05267"
}

variable "instance_disk_size" {
  description = "Size of instance EBS."
  default     = "10"
}

# Network.
variable "vpc_id" {
  type = string # TODO: convert in map.
}

variable "subnet_id" {
  type = string # TODO: convert in map.
}

variable "security_group" {
  type = string # TODO: convert in map.
}
