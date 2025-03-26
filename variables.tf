variable "loki_endpoint" {
  description = <<EOF
The endpoint of the Loki instance to send logs to.
Example: https://{your-publicly-facing-loki-endpoint}/loki/api/v1/push
EOF
  type        = string
}

variable "name_suffix" {
  description = "Suffix to append to the name of the resources"
  type        = string
  default     = ""
}

variable "policy_labels" {
  description = "Labels to apply to the policy"
  type        = list(string)
  default     = []
}

variable "space_id" {
  description = "The ID of the Space to create the resources in"
  type        = string
}

variable "webhook_labels" {
  description = "Labels to apply to the webhook"
  type        = list(string)
  default     = []
}
