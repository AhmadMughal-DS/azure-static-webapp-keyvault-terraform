locals {
  name_prefix = var.project_name
}

module "staticweb" {
  source       = "./modules/staticweb"
  name_prefix  = local.name_prefix
  location     = var.location
  swa_location = var.swa_location
  environment  = var.environment
}
