source "amazon-ebs" "symfony" {
  ami_name      = "symfony-web-image"
  ssh_username  = "ubuntu"
  encrypt_boot  = true
  instance_type = var.instance_type
  source_ami    = var.source_ami
  region        = var.aws_region
}

build {
  sources = ["source.amazon-ebs.symfony"]
  name = "build.amazon-ebs.symfony"
  provisioner "shell" {
      inline = [
        "DEBIAN_FRONTEND=noninteractive",
        "sudo apt-get update",
        "sudo apt-get upgrade -y",
        "sudo apt-get install apache2 apache2-bin apache2-utils -y",
        "sudo apt-get clean",
        "sudo rm -rf /var/lib/apt/lists/"
      ]
    }
}
