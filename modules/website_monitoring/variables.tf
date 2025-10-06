variable "prefix" {
  type = string
}

variable "account_id" {
  type = string
}

variable "distribution_id" {
  type = string
}

variable "cloudwatch_general_alarm_sns_arn" {
  type = string
}

variable "billing_alarm_threshold" {
  description = "the cost in $ of when to fire an alert"
  type        = number
  default     = 2
}