# Empacota os códigos Python em zips
data "archive_file" "lambda_a_zip" {
  type        = "zip"
  source_file = "${path.module}/src/lambda_a.py"
  output_path = "${path.module}/src/lambda_a.zip"
}

data "archive_file" "lambda_b_zip" {
  type        = "zip"
  source_file = "${path.module}/src/lambda_b.py"
  output_path = "${path.module}/src/lambda_b.zip"
}

resource "aws_lambda_function" "lambda_a" {
  function_name = "${var.project_name}-lambda-a"
  role          = aws_iam_role.lambda_a_role.arn
  handler       = "lambda_a.lambda_handler"
  runtime       = var.lambda_runtime
  filename      = data.archive_file.lambda_a_zip.output_path
  memory_size   = var.lambda_memory_mb
  timeout       = var.lambda_timeout_seconds
  publish       = true

  environment {
    variables = {
      TRIGGER_TIME_BRT = "08:30"
    }
  }
}

resource "aws_lambda_function" "lambda_b" {
  function_name = "${var.project_name}-lambda-b"
  role          = aws_iam_role.lambda_b_role.arn
  handler       = "lambda_b.lambda_handler"
  runtime       = var.lambda_runtime
  filename      = data.archive_file.lambda_b_zip.output_path
  memory_size   = var.lambda_memory_mb
  timeout       = var.lambda_timeout_seconds
  publish       = true

  environment {
    variables = {
      TRIGGER_TIME_BRT = "09:00"
    }
  }
}

# (Opcional) Log Groups explícitos com retenção
resource "aws_cloudwatch_log_group" "lg_a" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_a.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lg_b" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_b.function_name}"
  retention_in_days = 30
}
