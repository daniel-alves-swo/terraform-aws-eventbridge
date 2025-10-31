# IMPORTANTE: EventBridge usa UTC. Brasil (sem DST) = UTC-3.
# 08:30 BRT = 11:30 UTC → cron(30 11 * * ? *)
# 09:00 BRT = 12:00 UTC → cron(0 12 * * ? *)

resource "aws_cloudwatch_event_rule" "rule_a_daily_1130_utc" {
  name                = "${var.project_name}-rule-a-1130utc"
  description         = "Dispara Lambda A diariamente às 11:30 UTC (08:30 BRT)"
  schedule_expression = "cron(30 11 * * ? *)"
}

resource "aws_cloudwatch_event_rule" "rule_b_daily_1200_utc" {
  name                = "${var.project_name}-rule-b-1200utc"
  description         = "Dispara Lambda B diariamente às 12:00 UTC (09:00 BRT)"
  schedule_expression = "cron(0 12 * * ? *)"
}

resource "aws_cloudwatch_event_target" "target_a" {
  rule      = aws_cloudwatch_event_rule.rule_a_daily_1130_utc.name
  target_id = "lambda-a-target"
  arn       = aws_lambda_function.lambda_a.arn
}

resource "aws_cloudwatch_event_target" "target_b" {
  rule      = aws_cloudwatch_event_rule.rule_b_daily_1200_utc.name
  target_id = "lambda-b-target"
  arn       = aws_lambda_function.lambda_b.arn
}

# Permissões para o EventBridge invocar as Lambdas
resource "aws_lambda_permission" "allow_events_to_invoke_a" {
  statement_id  = "AllowExecutionFromEventBridgeA"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_a.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.rule_a_daily_1130_utc.arn
}

resource "aws_lambda_permission" "allow_events_to_invoke_b" {
  statement_id  = "AllowExecutionFromEventBridgeB"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_b.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.rule_b_daily_1200_utc.arn
}
