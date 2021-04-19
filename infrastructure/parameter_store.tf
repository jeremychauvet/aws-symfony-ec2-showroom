resource "aws_ssm_activation" "main" {
  name        = "test_ssm_activation"
  description = "Test"
  iam_role    = aws_iam_role.system_manager.id
  depends_on  = [aws_iam_role_policy_attachment.system_manager]
  tags        = var.tags
}

resource "aws_ssm_maintenance_window" "production" {
  name              = "production-maintenance-window-application"
  schedule          = "cron(0 16 ? * TUE *)"
  schedule_timezone = "America/Los_Angeles"
  duration          = 3
  cutoff            = 1
  tags              = var.tags
}
