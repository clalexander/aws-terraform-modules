resource "aws_guardduty_detector" "member" {
  enable                       = var.enable
  finding_publishing_frequency = var.publishing_frequency
  tags                         = var.tags
}
