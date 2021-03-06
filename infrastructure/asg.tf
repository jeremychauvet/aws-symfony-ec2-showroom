resource "aws_placement_group" "cluster" {
  name     = "dev.cluster.placement_group"
  strategy = "cluster"
}

// data "aws_ami" "symfony" {
//   executable_users = ["self"]
//   most_recent      = true
//   owners           = ["self"]
//   name_regex       = "^symfony-web-image"

//   filter {
//     name   = "name"
//     values = ["symfony-web-image"]
//   }

//   filter {
//     name   = "root-device-type"
//     values = ["ebs"]
//   }

//   filter {
//     name   = "virtualization-type"
//     values = ["hvm"]
//   }
// }

resource "aws_autoscaling_group" "aza" {
  name            = "dev.aza.aws_autoscaling_group"
  max_size        = 2
  min_size        = 1
  force_delete    = true
  placement_group = aws_placement_group.cluster.id

  launch_template {
    id      = aws_launch_template.symfony.id
    version = "$Latest"
  }

  availability_zones = ["${var.aws_region}a"]

  timeouts {
    delete = "5m"
  }

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }
}

# Create a new load balancer attachment
resource "aws_autoscaling_attachment" "asg_attachment_alb" {
  autoscaling_group_name = aws_autoscaling_group.aza.id
  alb_target_group_arn   = aws_lb_target_group.http.arn
}
