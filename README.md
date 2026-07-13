# Netflix Platform - Infrastructure

## Overview

This repository provisions the cloud infrastructure for the Netflix Platform on Google Cloud Platform using Terraform.

The goal is to simulate a production-style DevOps environment with Infrastructure as Code, Kubernetes, CI/CD, and Gateway API.

---

## Technology Stack

- Terraform
- Google Cloud Platform
- Google Kubernetes Engine (GKE)
- Artifact Registry
- Cloud NAT
- Cloud Router
- IAM
- Service Accounts

---

## Repository Structure

```
modules/
├── apis
├── network
├── artifact-registry
├── service-account
└── gke
```

---

## Infrastructure Components

- Google Cloud API Enablement
- VPC
- Private Subnet
- Secondary IP Ranges
- Firewall Rules
- Cloud Router
- Cloud NAT
- Artifact Registry
- Dedicated GKE Service Account
- IAM Roles
- Standard GKE Cluster

---

## Deployment Order

1. Enable Google APIs
2. Create Network
3. Configure Router and NAT
4. Create Artifact Registry
5. Create Service Account
6. Provision GKE Cluster

---

## Current Status

- [x] APIs
- [x] Network
- [x] Firewall
- [x] Cloud NAT
- [x] Artifact Registry
- [x] Service Account
- [ ] GKE (In Progress)

---

## Next Repository

After infrastructure provisioning, Kubernetes manifests, Gateway API configuration, and CI/CD pipelines will be maintained in the `netflix-deployment` repository.