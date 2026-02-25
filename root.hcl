locals {
  subscription_vars = read_terragrunt_config(find_in_parent_folders("subscription.hcl"))
  subscription_id   = local.subscription_vars.locals.subscription_id

  databricks_account_vars = read_terragrunt_config(find_in_parent_folders("databricks_account.hcl"))
  databricks_account_id = local.databricks_account_vars.locals.id
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

# Generate an DBX provider block
generate "provider" {
  path      = "databricks_acc_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "databricks" {
  profile = "andreas.ottosson_tutamail.com#ext#@andreasottossontutamail.onmicrosoft.com"
  account_id = "${local.databricks_account_id}"
}
EOF
}

remote_state {
  backend = "local"
  config = {
    path = "${get_parent_terragrunt_dir()}/.terragrunt-local-state/${path_relative_to_include()}/tofu.tfstate"
  }

  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
