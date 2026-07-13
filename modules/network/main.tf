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

resource "google_compute_firewall" "allow_internal" {

  name    = "allow-internal-${var.environment}"
  project = var.project_id
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [
    "10.10.0.0/24",
    "10.20.0.0/16",
    "10.30.0.0/20"
  ]

}

resource "google_compute_firewall" "allow_ssh" {

  name    = "allow-ssh-${var.environment}"
  project = var.project_id
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [
    "0.0.0.0/0"
  ]

}

resource "google_compute_router" "router" {

  name    = "netflix-router-${var.environment}"
  region  = var.region
  project = var.project_id
  network = google_compute_network.vpc.id

}

resource "google_compute_router_nat" "nat" {

  name   = "netflix-nat-${var.environment}"
  router = google_compute_router.router.name

  region = var.region
  project = var.project_id

  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

}