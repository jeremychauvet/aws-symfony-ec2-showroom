# Instance.
resource "aws_instance" "web" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  tags            = var.tags
  security_groups = [var.security_group]
  subnet_id       = var.subnet_id

  root_block_device {
    encrypted   = true
    volume_size = var.instance_disk_size
  }

  metadata_options {
    http_tokens = "required"
  }
}

# Monitoring.

# Alerting
