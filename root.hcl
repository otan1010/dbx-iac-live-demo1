#locals {
#  sub_vars = read_terragrunt_config(find_in_parent_folders("subscription.hcl"))
#  sub_id   = local.sub_vars.locals.subscription_id
#}

locals {
  sub_vars = read_terragrunt_config(find_in_parent_folders("subscription.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  environment_abbreviation = local.sub_vars.locals.environment_abbreviation
  region                   = local.region_vars.locals.region
  sub_id   = local.sub_vars.locals.subscription_id
}

# Generate an AZ provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}
  subscription_id = "${local.sub_id}"
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

############
# Optional: expose common values to children via inputs
# (children can merge/override as needed)
inputs = {
  environment_abbreviation = local.environment_abbreviation
  region                   = local.region
}
############
