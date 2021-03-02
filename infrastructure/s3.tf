resource "aws_s3_bucket" "lb_access_logs" {
  bucket = "aws-lb-http-access-logs-myonlinebookstore"
  acl    = "private"

  policy = file("./policies/dev.nlb-s3.policy.json")

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
