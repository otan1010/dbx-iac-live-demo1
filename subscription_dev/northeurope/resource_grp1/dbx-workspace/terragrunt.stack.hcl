unit "resource_group1" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/resource_group?ref=main"
  path = "res_grp1"
  #values = {
  #  version = "main"
  #  name              = "${replace(local.name, "-", "")}db"
  #}
}

unit "resource_group2" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/resource_group?ref=main"
  path = "res_grp2"
}
