data "aws_caller_identity" "current" {}

# Fault Injection Service.
resource "aws_iam_policy" "fis" {
  name   = "dev.fis.policy"
  policy = file("policies/dev.fis.policy.json")
}

resource "aws_iam_role" "fis" {
  name               = "dev.fis.role"
  description        = "Role used to perform fault injection in EC2 and RDS"
  assume_role_policy = file("policies/dev.fis-tr.policy.json")
}

resource "aws_iam_role_policy_attachment" "fis" {
  role       = aws_iam_role.fis.name
  policy_arn = aws_iam_policy.fis.arn
}

# System Manager
resource "aws_iam_instance_profile" "asg" {
  name = "dev.asg.profile"
  role = aws_iam_role.asg.name
}

resource "aws_iam_role" "asg" {
  name               = "dev.asg.role"
  description        = "Role to attach to instances launch by ASG."
  assume_role_policy = file("policies/dev.asg.policy.json")
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.asg.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.asg.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# ASG.
resource "aws_iam_service_linked_role" "asg" {
  aws_service_name = "autoscaling.amazonaws.com"
  custom_suffix    = "CMK"
}
