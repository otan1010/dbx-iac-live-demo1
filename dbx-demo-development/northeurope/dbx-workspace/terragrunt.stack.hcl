locals {
  sub_vars = read_terragrunt_config(find_in_parent_folders("subscription.hcl"))
  env = local.sub_vars.locals.environment_abbreviation

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region = local.region_vars.locals.region

  dbx_name_core = "dbx-${local.env}-${local.region}"
  dbx_name_managed = "dbx-${local.env}-${local.region}-managed"
}

unit "core_databricks_resource_group" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/resource_group?ref=main"
  path = "rg-${local.dbx_name_core}"
  values = {
    name = "rg-${local.dbx_name_core}"
    region = "${local.region}"
  }
}

unit "managed_databricks_resource_group" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/resource_group?ref=main"
  path = "rg-${local.dbx_name_core}-managed"
  values = {
    name = "rg-${local.dbx_name_core}-managed"
    region = "${local.region}"
  }
}
