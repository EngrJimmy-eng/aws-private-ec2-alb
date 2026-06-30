output "topic_arn" {
  description = "SNS Topic ARN"
  value       = aws_sns_topic.alerts.arn
}

output "topic_name" {
  description = "SNS Topic Name"
  value       = aws_sns_topic.alerts.name
}
