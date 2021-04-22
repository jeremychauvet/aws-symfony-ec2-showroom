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
resource "aws_iam_instance_profile" "ec2" {
  name = "dev.ec2-ssm-cloudwatch.profile"
  role = aws_iam_role.ssm.name
}

resource "aws_iam_role" "ssm" {
  name               = "dev.ssm.role"
  description        = "Role to attach to the managed instance."
  assume_role_policy = file("policies/dev.ssm.policy.json")
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_policy" "kms" {
  name   = "dev.kms.policy"
  policy = file("policies/dev.kms.policy.json")
}

resource "aws_iam_role_policy_attachment" "kms" {
  role       = aws_iam_role.ssm.name
  policy_arn = aws_iam_policy.kms.arn
}

# ASG.
resource "aws_iam_service_linked_role" "asg" {
  aws_service_name = "autoscaling.amazonaws.com"
  custom_suffix    = "CMK"
}
