#Databricks Metastore-level resources should be created here

locals {
  metastore_vars = read_terragrunt_config(find_in_parent_folders("metastore.hcl"))
  metastore = local.metastore_vars.locals.name

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region = local.region_vars.locals.name

  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  environment = local.environment_vars.locals.name

  metastore_name_primary = "metastore-${local.environment}-${local.region}"
}

unit "databricks_metastore_primary" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/databricks_metastore?ref=main"
  path = "rg-${local.metatore_name_primary}"
  values = {
    version = "main"
    name = "rg-${local.metatore_name_primary}"
    region = "${local.region}"
  }
}
