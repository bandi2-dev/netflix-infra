locals {
  required_services = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "servicenetworking.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "dns.googleapis.com"
  ]
}

resource "google_project_service" "services" {
  for_each = toset(local.required_services)

  project = var.project_id
  service = each.key

  disable_on_destroy = false
}