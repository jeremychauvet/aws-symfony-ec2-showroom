# Common.
variable "aws_region" {
  description = "AWS region where AMI can be used."
  default     = "us-east-1"
}

variable "tags" {
  description = "Tags used to ABAC and billing."
  type        = map(string)
  default = {
    CreatedBy = "Terraform"
    Project   = "MyOnlineBookStore"
  }
}

# Compute.
variable "ami_id" {
  description = "ID of AMI to use."
  default     = "ami-0064d21c3ab673bf8"
}

variable "instance_type" {
  description = "Type of instance used."
  default     = "c5.large"
}
