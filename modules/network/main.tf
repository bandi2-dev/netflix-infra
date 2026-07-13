resource "google_compute_network" "vpc" {

  name                    = "${var.network_name}-${var.environment}"
  project                 = var.project_id
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"

}

resource "google_compute_subnetwork" "subnet" {

  name                     = "${var.subnet_name}-${var.environment}"
  project                  = var.project_id
  region                   = var.region
  network                  = google_compute_network.vpc.id
  ip_cidr_range            = var.subnet_cidr
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "gke-pods"
    ip_cidr_range = var.pods_cidr
  }

  secondary_ip_range {
    range_name    = "gke-services"
    ip_cidr_range = var.services_cidr
  }

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

}