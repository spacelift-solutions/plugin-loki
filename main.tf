locals {
  name          = var.name_suffix != "" ? "loki-${var.name_suffix}" : "Loki"
  policy_labels = concat(var.policy_labels, ["autoattach:plugin_loki"])
}

resource "spacelift_named_webhook" "this" {
  enabled  = true
  endpoint = var.loki_endpoint
  name     = local.name
  labels   = var.webhook_labels

  space_id = var.space_id
}

resource "spacelift_policy" "this" {
  name   = local.name
  type   = "NOTIFICATION"
  labels = local.policy_labels

  body = templatefile("${path.module}/loki_logs.tpl.rego", {
    webhook_id = spacelift_named_webhook.this.id
  })

  space_id = var.space_id
}