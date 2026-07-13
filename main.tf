module "apis" {
  source = "./modules/apis"

  project_id = var.project_id
}

module "network" {
  source = "./modules/network"

  project_id = var.project_id
  region = var.region
  environment = var.environment

  network_name = local.network_name
  subnet_name = local.subnet_name

  subnet_cidr = "10.10.0.0/24"
  pods_cidr = "10.20.0.0/16"
  services_cidr = "10.30.0.0/20"
}

module "artifact_registry" {
  source = "./modules/artifact-registry"

  project_id = var.project_id
  region = var.region
  environment = var.environment
}

module "service_account" {
  source = "./modules/service-account"

  project_id = var.project_id
  environment = var.environment
}

module "gke" {

  source = "./modules/gke"

  project_id = var.project_id

  region = var.region

  zone = var.zone

  environment = var.environment

  network = module.network.network_name

  subnetwork = module.network.subnet_name

  service_account = module.service_account.email

}