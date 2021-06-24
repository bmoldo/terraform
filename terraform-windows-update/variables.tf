variable "region" {}
variable "profile" {}

variable "env" {
  description = "Specifies environment"
  type        = string
}

variable "application_tag_value" {
  description = "Specifies application tag values"
  type        = list
  default     = []
}

variable "key"{
  description = "this is the target key associated with the ec2 instance"
  type        = string
  default     = "tag:application"
 }
