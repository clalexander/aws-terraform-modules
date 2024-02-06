variable "enable" {
  description = "Enable GuardDuty"
  type        = bool
  default     = true
}

variable "publishing_frequency" {
  description = "GuardDuty findings publishing frequency."
  default     = "SIX_HOURS"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all stack resources."
  default     = {}
  type        = map(any)
}
