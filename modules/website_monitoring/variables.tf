variable "prefix" {
  type = string
}

variable "tags" {
  type = map(string)
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