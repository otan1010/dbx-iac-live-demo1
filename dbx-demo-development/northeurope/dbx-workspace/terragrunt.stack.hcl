locals {
  sub_vars = read_terragrunt_config(find_in_parent_folders("subscription.hcl"))
  env = local.sub_vars.locals.environment_abbreviation

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region = local.region_vars.locals.region

  rg_prefix = "rg"

  databricks_resource_group_core = "${local.rg_prefix}-dbx-${local.env}-${local.region}"
  databricks_resource_group_managed = "${local.rg_prefix}-dbx-${local.env}-${local.region}-managed"
}

unit "core_databricks_resource_group" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/resource_group?ref=main"
  path = "${local.databricks_resource_group_core}"
  values = {
    name = "${local.databricks_resource_group_core}"
    region = "${local.region}"
  }
}
