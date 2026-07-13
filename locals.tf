locals {

  project = "netflix"

  common_labels = {
    project     = local.project
    environment = var.environment
    owner       = var.owner
    managed_by  = "terraform"
  }

}