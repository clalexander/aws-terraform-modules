output "detector_id" {
  description = "The member ID of the GuardDuty detector."
  value       = aws_guardduty_detector.member.id
}
