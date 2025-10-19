variable "billing_alarm_threshold" {
  description = "the cost in $ of when to fire an alert"
  type        = number
  default     = 2
}

variable "alert_email" {
  type = string
  validation {
    condition     = can(regex("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$", var.alert_email))
    error_message = "Invalid email address"
  }
}

variable "over_budget_sns_topic_arn" {
  type = string
}