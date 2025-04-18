data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/backup.py"
  output_path = "${path.module}/lambda/backup.zip"
}

resource "aws_lambda_function" "ebs_backup" {
  function_name = "ebs-daily-backup"
  role          = aws_iam_role.lambda_role.arn
  handler       = "backup.backup_handler"
  runtime       = "python3.12"
  filename      = data.archive_file.lambda_zip.output_path

  memory_size         = 128
  ephemeral_storage {
    size = 512
  }
  timeout             = 20

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}

resource "aws_cloudwatch_event_rule" "daily_backup" {
  name                = "daily-ebs-backup"
  description         = "Daily EBS Backup"
  schedule_expression = "cron(0 5 * * ? *)"
}

resource "aws_cloudwatch_event_target" "trigger_lambda" {
  rule      = aws_cloudwatch_event_rule.daily_backup.name
  target_id = "ebs-backup"
  arn       = aws_lambda_function.ebs_backup.arn
}

resource "aws_lambda_permission" "allow_events" {
  statement_id  = "ebs-backup"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ebs_backup.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.daily_backup.arn
}
