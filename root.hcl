locals {
  # Automatically load subscription-level variables
  subscription_vars = read_terragrunt_config(find_in_parent_folders("subscription.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load region-level variables
  resourcegroup_vars = read_terragrunt_config(find_in_parent_folders("resourcegroup.hcl"))

  # Extract the variables we need for easy access
  subscription_name = local.subscription_vars.locals.subscription_name
  subscription_id   = local.subscription_vars.locals.azure_subscription_id
  azure_region   = local.region_vars.locals.azure_region
  resourcegroup_name   = local.resourcegroup_vars.locals.resourcegroup_name
}

# Generate an AZ provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}
  subscription_id = "${local.subscription_id}"
}
EOF
}
