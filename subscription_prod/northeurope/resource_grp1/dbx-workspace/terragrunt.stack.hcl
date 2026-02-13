locals {
  resourcegroup_vars = read_terragrunt_config(find_in_parent_folders("resourcegroup.hcl"))
  path = local.resourcegroup_vars.locals.azure_resourcegroup_name
}

unit "resource_group" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/resource_group?ref=main"
  path = local.path
}
