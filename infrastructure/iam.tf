data "aws_caller_identity" "current" {}

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

resource "aws_iam_role" "system_manager" {
  name               = "dev.system_manager_role"
  description        = "Role to attach to the managed instance."
  assume_role_policy = file("policies/dev.system_manager.policy.json")
}

resource "aws_iam_role_policy_attachment" "system_manager" {
  role       = aws_iam_role.system_manager.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
