#unit "resource_group" {
#  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/resource_group?ref=main"
#  path = "resource_group123"
#}

unit "resource_group" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/resource_group?ref=main"
  path   = "resource_group123"

  # What is unique for this instance
  values = {
    rg_name = "platform"
  }
}
