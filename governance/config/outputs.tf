output "config_role_arn" {
  description = "Config service-linked role ARN."
  value       = aws_iam_service_linked_role.config.arn
}
