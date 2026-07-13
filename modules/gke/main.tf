resource "google_container_cluster" "gke" {

  name     = "netflix-gke-${var.environment}"
  location = var.region
  project  = var.project_id

  network    = var.network
  subnetwork = var.subnetwork

  remove_default_node_pool = true
  initial_node_count       = 1

  deletion_protection = true

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

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  addons_config {

    http_load_balancing {
      disabled = false
    }

    horizontal_pod_autoscaling {
      disabled = false
    }

  }

  network_policy {
    enabled = true
  }

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

}

resource "google_container_node_pool" "primary" {

  name     = "primary-node-pool"
  cluster  = google_container_cluster.gke.name
  location = var.region
  project  = var.project_id

  node_count = 1

  autoscaling {

    min_node_count = 1

    max_node_count = 2

  }

  node_config {

    machine_type = "e2-medium"

    service_account = var.service_account

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      environment = var.environment
    }

    disk_size_gb = 50

    disk_type = "pd-balanced"

  }

  management {

    auto_repair = true

    auto_upgrade = true

  }

}