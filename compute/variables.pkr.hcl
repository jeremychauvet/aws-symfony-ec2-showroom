variable "aws_region" {
  description = "AWS region where AMI can be used."
  default     = "us-east-1"
}

variable "source_ami" {
  description = "Source AMI."
  default     = "ami-02ae530dacc099fc9"
}

variable "instance_type" {
  description = "Type of instance used."
  default     = "t3.micro"
}
