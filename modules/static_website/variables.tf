variable "prefix" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "namespace" {
  description = "A short unique string wihout spechas chars that is used to name resouces e.g your name"
  type        = string
}

variable "website_name" {
  type        = string
  description = "e.g example.com"
}

variable dns_ttl {
  default     = 300
  type        = number
  description = "The Time To Live of all records."
}

variable "extra_a_records" {
  type    = map(list(string))
  default = {}
}

variable "extra_aaaa_records" {
  type    = map(list(string))
  default = {}
}

variable "email_mx_records" {
  type        = list(string)
  description = "e.g '['10 mainserver', '20 secondserver']' "
}

variable "main_txt_records" {
  type        = list(string)
  description = "e.g '['somthing 1 ', 'somthing 2']' "
}

variable "extra_txt_records" {
  type    = map(list(string))
  default = {}
}
