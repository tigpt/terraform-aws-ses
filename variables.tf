# General
variable "domain" {
  type        = string
  description = "Domain to use with SES"
}

variable "zone_id" {
  description = "zone_id for the route 53 resource"
  type        = string
}

variable "quarentine_email" {
  description = "quarentine_email for dmarc"
  type        = string
}

# Other
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tag for all resources"
}
