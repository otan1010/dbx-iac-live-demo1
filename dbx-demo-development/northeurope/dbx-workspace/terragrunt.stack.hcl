locals {
  sub_vars = read_terragrunt_config(find_in_parent_folders("subscription.hcl"))
  env = local.sub_vars.locals.environment_abbreviation

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region = local.region_vars.locals.region

  rg_prefix = "rg"
}

unit "resource_group" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/resource_group?ref=main"
  path = "${local.rg_prefix}-dbx-${local.env}-${local.region}"
  values = {
    name = "${local.rg_prefix}-dbx-${local.env}-${local.region}"
    region = "${local.region}"
  }
}
