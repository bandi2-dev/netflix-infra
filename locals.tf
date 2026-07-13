locals {

  project_name = "netflix"

  network_name = "${local.project_name}-vpc"

  subnet_name = "${local.project_name}-subnet"

  common_labels = {
    project     = local.project_name
    owner       = var.owner
    environment = var.environment
    managed_by  = "terraform"
  }

}