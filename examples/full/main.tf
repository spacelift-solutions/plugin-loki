module "plugin_loki" {
  source = "spacelift.io/spacelift-solutions/plugin-loki/spacelift"

  # Required Variables
  loki_endpoint = "https://loki.example.com/loki/api/v1/push"
  space_id      = "root"

  # Optional Variables
  name_suffix    = "loki"
  policy_labels  = ["production"]
  webhook_labels = ["production"]
}