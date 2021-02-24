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
