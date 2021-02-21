variable "aws_region" {
  description = "AWS region where AMI can be used."
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Type of instance used."
  default     = "t3.micro"
}

variable "ami_name" {
  description = "Name of base AMI to use."
  default     = "symfony-web-image"
}

variable "tags" {
  description = "Tags used to ABAC and billing."
  type        = map(string)
  default = {
    CreatedBy = "Terraform"
    Project = "MyOnlineBookStore"
  }
}
