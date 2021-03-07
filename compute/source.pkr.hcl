source "amazon-ebs" "symfony" {
  ami_name      = "symfony-web-image"
  ssh_username  = "ubuntu"
  encrypt_boot  = true
  instance_type = "t3.micro"
  source_ami    = "ami-02ae530dacc099fc9"
  region        = "us-east-1"
}

build {
  sources = ["source.amazon-ebs.symfony"]
  name = "build.amazon-ebs.symfony"
  provisioner "shell" {
      inline = [
        "DEBIAN_FRONTEND=noninteractive",
        "sudo apt-get update && sudo apt-get upgrade -y",
        "sudo apt-get install apache2 apache2-bin apache2-utils ec2-instance-connect -y"
      ]
    }
}
