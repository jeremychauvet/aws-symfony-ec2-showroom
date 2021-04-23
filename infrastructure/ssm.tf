resource "aws_ssm_activation" "ssm" {
  name               = "ssm_activation"
  iam_role           = aws_iam_role.asg.id
  registration_limit = "5"
}

resource "aws_ssm_maintenance_window" "production" {
  name              = "production-maintenance-window-application"
  schedule          = "cron(0 16 ? * TUE *)"
  schedule_timezone = "America/Los_Angeles"
  duration          = 3
  cutoff            = 1
  tags              = var.tags
}
