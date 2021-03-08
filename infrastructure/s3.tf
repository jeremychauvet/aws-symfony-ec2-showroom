data "aws_elb_service_account" "main" {}

resource "aws_s3_bucket" "lb_access_logs" {
  bucket = "aws-lb-access-logs-myonlinebookstore"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

  tags = var.tags

  #checkov:skip=CKV_AWS_52:Ensure S3 bucket has MFA delete enabled
  #checkov:skip=CKV_AWS_18:Ensure the S3 bucket has access logging enabled
}

resource "aws_s3_bucket_policy" "lb_access_logs" {
  bucket = aws_s3_bucket.lb_access_logs.id
  policy = templatefile("./policies/dev.nlb-s3.policy.json.tpl", { aws_region = var.aws_region, elb_account_arn = data.aws_elb_service_account.main.arn, aws_account_id = data.aws_caller_identity.current.account_id })
}
