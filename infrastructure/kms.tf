resource "aws_kms_key" "ebs" {
  description             = "Customer key used to encrypt / decrypt EBS volumes."
  deletion_window_in_days = 10
  enable_key_rotation     = true
  tags                    = var.tags
  policy                  = file("policies/dev.kms-ebs.policy.json")
}

resource "aws_kms_alias" "ebs" {
  name          = "alias/custom/ebs"
  target_key_id = aws_kms_key.ebs.key_id
}

resource "aws_ebs_default_kms_key" "main" {
  key_arn = aws_kms_key.ebs.arn
}

resource "aws_kms_grant" "ebs" {
  name              = "GrantAccessToASG"
  key_id            = aws_kms_key.ebs.key_id
  grantee_principal = aws_iam_role.asg.arn
  operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]
}
