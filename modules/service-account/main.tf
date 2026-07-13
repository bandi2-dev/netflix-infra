resource "google_service_account" "gke_sa" {

  account_id   = "netflix-gke-${var.environment}"

  display_name = "Netflix GKE Service Account"

  project = var.project_id

}

resource "google_project_iam_member" "artifact_registry_reader" {

  project = var.project_id

  role = "roles/artifactregistry.reader"

  member = "serviceAccount:${google_service_account.gke_sa.email}"

}

resource "google_project_iam_member" "logging_writer" {

  project = var.project_id

  role = "roles/logging.logWriter"

  member = "serviceAccount:${google_service_account.gke_sa.email}"

}

resource "google_project_iam_member" "monitoring_writer" {

  project = var.project_id

  role = "roles/monitoring.metricWriter"

  member = "serviceAccount:${google_service_account.gke_sa.email}"

}