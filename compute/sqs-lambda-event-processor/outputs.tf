output "events_queue" {
  description = "The SQS queue that receives events from the source."
  value       = aws_sqs_queue.events
}
