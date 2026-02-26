locals {
  databricks_account_vars = read_terragrunt_config(find_in_parent_folders("account_dbx.hcl"))
  databricks_account_id = local.databricks_account_vars.locals.id
}

# Generate an DBX provider block
generate "provider" {
  path      = "databricks_account_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "databricks" {
  profile = "andreas.ottosson_tutamail.com#ext#@andreasottossontutamail.onmicrosoft.com"
  account_id = "${local.databricks_account_id}"
}
EOF
}
