output "lambda_a_arn" {
  description = "ARN da Lambda A"
  value       = aws_lambda_function.lambda_a.arn
}

output "lambda_b_arn" {
  description = "ARN da Lambda B"
  value       = aws_lambda_function.lambda_b.arn
}

output "rule_a_arn" {
  description = "ARN da regra do EventBridge para 11:30 UTC (08:30 BRT)"
  value       = aws_cloudwatch_event_rule.rule_a_daily_1130_utc.arn
}

output "rule_b_arn" {
  description = "ARN da regra do EventBridge para 12:00 UTC (09:00 BRT)"
  value       = aws_cloudwatch_event_rule.rule_b_daily_1200_utc.arn
}
