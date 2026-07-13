resource "google_container_cluster" "gke" {

  name     = "netflix-gke-${var.environment}"
  location = var.region
  project  = var.project_id

  network    = var.network
  subnetwork = var.subnetwork

  deletion_protection = false

  remove_default_node_pool = true
  initial_node_count       = 1

  networking_mode = "VPC_NATIVE"

  release_channel {
    channel = "REGULAR"
  }

  gateway_api_config {
    channel = "CHANNEL_STANDARD"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pods"
    services_secondary_range_name = "gke-services"
  }

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

}

resource "google_container_node_pool" "primary" {

  name     = "primary-pool"
  project  = var.project_id
  location = var.region
  cluster  = google_container_cluster.gke.name

  node_count = 1

  node_config {

    machine_type = "e2-medium"

    disk_type = "pd-standard"

    disk_size_gb = 20

    service_account = var.service_account

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      environment = var.environment
    }

  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

}