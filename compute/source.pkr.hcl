source "amazon-ebs" "symfony" {
  ami_name      = "symfony-web-image"
  ssh_username  = "ubuntu"
  encrypt_boot  = true
  kms_key_id    = "alias/packer"
  instance_type = "c5.large"
  source_ami    = "ami-02ae530dacc099fc9"
  region        = "us-east-1"
  force_deregister = true
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
