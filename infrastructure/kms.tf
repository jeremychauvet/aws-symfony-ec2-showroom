resource "aws_kms_key" "ebs" {
  description             = "EBS key."
  deletion_window_in_days = 10
  enable_key_rotation     = true
  tags                    = var.tags
}

resource "aws_ebs_default_kms_key" "main" {
  key_arn = aws_kms_key.ebs.arn
}
