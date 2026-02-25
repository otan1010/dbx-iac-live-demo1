#Workspace level configuration should be done here

locals {
  metastore_vars = read_terragrunt_config(find_in_parent_folders("metastore.hcl"))
  metastore = local.metastore_vars.locals.name

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region = local.region_vars.locals.name

  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  environment = local.environment_vars.locals.name

  #subscription_vars = read_terragrunt_config(find_in_parent_folders("subscription.hcl"))
  #environment = local.subscription_vars.locals.name

  dbx_name_core = "dbx-${local.environment}-${local.region}"
}

unit "core_databricks_resource_group" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/resource_group?ref=main"
  path = "rg-${local.dbx_name_core}"
  values = {
    version = "main"
    name = "rg-${local.dbx_name_core}"
    region = "${local.region}"
  }
}

unit "managed_databricks_resource_group" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/resource_group?ref=main"
  path = "rg-${local.dbx_name_core}-managed"
  values = {
    version = "main"
    name = "rg-${local.dbx_name_core}-managed"
    region = "${local.region}"
  }
}
