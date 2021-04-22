resource "aws_placement_group" "cluster" {
  name     = "dev.cluster.placement_group"
  strategy = "cluster"
}

# AZa.
// resource "aws_autoscaling_group" "aza" {
//   name                 = "dev.aza.aws_autoscaling_group"
//   max_size             = 4
//   min_size             = 1
//   force_delete         = true
//   placement_group      = aws_placement_group.cluster.id
//   termination_policies = ["OldestInstance"]

//   launch_template {
//     id      = aws_launch_template.symfony.id
//     version = "$Latest"
//   }

//   service_linked_role_arn = aws_iam_service_linked_role.asg.arn

//   // Launch instances in private subnet of AZa.
//   vpc_zone_identifier = [module.vpc.private_subnets[0]]

//   timeouts {
//     delete = "5m"
//   }

//   lifecycle {
//     ignore_changes = [load_balancers, target_group_arns]
//   }
// }

// resource "aws_autoscaling_attachment" "asg_attachment_alb_aza" {
//   autoscaling_group_name = aws_autoscaling_group.aza.id
//   alb_target_group_arn   = aws_lb_target_group.aza.arn
// }

# AZb.
// resource "aws_autoscaling_group" "azb" {
//   name                 = "dev.azb.aws_autoscaling_group"
//   max_size             = 2
//   min_size             = 1
//   force_delete         = true
//   placement_group      = aws_placement_group.cluster.id
//   termination_policies = ["OldestInstance"]

//   launch_template {
//     id      = aws_launch_template.symfony.id
//     version = "$Latest"
//   }

//   // Launch instances in private subnet of AZa.
//   vpc_zone_identifier = [module.vpc.private_subnets[1]]

//   timeouts {
//     delete = "5m"
//   }

//   lifecycle {
//     ignore_changes = [load_balancers, target_group_arns]
//   }
// }

// resource "aws_autoscaling_attachment" "asg_attachment_alb_azb" {
//   autoscaling_group_name = aws_autoscaling_group.azb.id
//   alb_target_group_arn   = aws_lb_target_group.azb.arn
// }
