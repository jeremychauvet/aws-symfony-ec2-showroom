data "amazon-ami" "ubuntu" {
  filters = {
    virtualization-type = "hvm"
    name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server*"
    root-device-type    = "ebs"
  }
  owners      = ["099720109477"]
  most_recent = true
  region      = "us-east-1"
}

source "amazon-ebs" "symfony" {
  ami_name      = "symfony-web-image"
  ssh_username  = "ubuntu"
  encrypt_boot  = true
  kms_key_id    = "alias/packer"
  instance_type = "c5.large"
  source_ami    = data.amazon-ami.ubuntu.id
  region        = "us-east-1"
  force_deregister = true
  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
    http_put_response_hop_limit = 1
  }
}

build {
  sources = ["source.amazon-ebs.symfony"]
  name = "build.amazon-ebs.symfony"

  provisioner "ansible" {
    playbook_file = "playbook.yml"
  }
}

// source "docker" "qa" {
//     image = "ghcr.io/jeremychauvet/ubuntu-ansible:20.04"
//     commit = true
// }

// build {
//   sources = ["source.docker.qa"]
//   name = "build.docker.qa"

//   provisioner "ansible" {
//     playbook_file = "playbook.yml"
//   }

//   provisioner "apache-vhost" {
//     source = "app.tar.gz"
//     destination = "/tmp/app.tar.gz"
//   }
// }
