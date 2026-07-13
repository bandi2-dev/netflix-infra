variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "Deployment Region"
  type        = string
}

variable "zone" {
  description = "Primary Zone"
  type        = string
}

variable "environment" {
  description = "Deployment Environment"
  type        = string
}

variable "owner" {
  description = "Project Owner"
  type        = string
}