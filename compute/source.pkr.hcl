# source "amazon-ebs" "symfony" {
#   ami_name      = "symfony-web-image"
#   ssh_username  = "ubuntu"
#   encrypt_boot  = true
#   kms_key_id    = "alias/packer"
#   instance_type = "c5.large"
#   source_ami    = "ami-02ae530dacc099fc9"
#   region        = "us-east-1"
#   force_deregister = true
# }

source "docker" "qa" {
    //image = "ubuntu-ansible:latest"
    image = "ghcr.io/jeremychauvet/ubuntu:20.04"
    commit = true
    privileged = true
}

# build {
#   sources = ["source.amazon-ebs.symfony"]
#   name = "build.amazon-ebs.symfony"

#   provisioner "shell" {
#     inline = [
#       "DEBIAN_FRONTEND=noninteractive",
#       "sudo apt-get update && sudo apt-get upgrade -y",
#       "sudo apt-get install apache2 apache2-bin apache2-utils -y"
#     ]
#   }
# }

build {
  sources = ["source.docker.qa"]
  name = "build.docker.qa"

  provisioner "ansible" {
    playbook_file = "playbook.yml"
  }

  # provisioner "apache-vhost" {
  #   source = "app.tar.gz"
  #   destination = "/tmp/app.tar.gz"
  # }
}
