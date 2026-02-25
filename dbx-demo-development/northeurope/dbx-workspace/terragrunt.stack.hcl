locals {
  resource_group_vars = read_terragrunt_config(find_in_parent_folders("resource_groups.hcl"))
  resource_group_prefix = local.resource_group_vars.locals.resource_group_prefix

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  path = local.region_vars.locals.region
}

unit "resource_group" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/resource_group?ref=main"
  path = "resource_group123"
}
