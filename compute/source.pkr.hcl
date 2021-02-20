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
        "sudo apt-get update"
      ]
    }
}
