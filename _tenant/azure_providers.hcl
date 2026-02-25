locals {
  subscription_vars = read_terragrunt_config(find_in_parent_folders("subscription.hcl"))
  subscription_id   = local.subscription_vars.locals.subscription_id
}

# Generate an AZ provider block
generate "provider" {
  path      = "az_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}
  subscription_id = "${local.subscription_id}"
}
EOF
}
