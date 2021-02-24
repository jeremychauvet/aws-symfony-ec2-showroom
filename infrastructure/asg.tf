resource "aws_placement_group" "cluster" {
  name     = "dev.cluster.placement_group"
  strategy = "cluster"
}

resource "aws_launch_template" "symfony" {
  image_id      = var.ami_id
  instance_type = var.instance_type
}

resource "aws_autoscaling_group" "aza" {
  name                      = "dev.aza.aws_autoscaling_group"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  placement_group           = aws_placement_group.cluster.id

  launch_template {
    id      = aws_launch_template.symfony.id
    version = "$Latest"
  }

  availability_zones = ["${var.aws_region}a"]

  initial_lifecycle_hook {
    name                 = "foobar"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 2000
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
  }

  timeouts {
    delete = "15m"
  }
}
