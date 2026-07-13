resource "google_artifact_registry_repository" "docker_repo" {

  project = var.project_id

  location = var.region

  repository_id = "netflix-${var.environment}"

  description = "Docker repository for Netflix Platform"

  format = "DOCKER"

}