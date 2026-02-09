# Button0 – Infrastructure (Terraform)

## Overview

This repository is responsible for all cloud infrastructure required to run the Button0 application.

The infrastructure is built entirely using Terraform and targets AWS as the cloud provider.
It follows Infrastructure as Code (IaC) principles:

- No manual setup in the AWS Console
- Full reproducibility
- Version-controlled infrastructure
- Safe creation and destruction of environments

This repository does NOT contain application code or Kubernetes manifests.
Its sole responsibility is provisioning cloud resources.

---

## Responsibilities of This Repository

This repository provisions and manages:

- AWS networking (VPC, subnets, routing)
- Amazon EKS (Kubernetes cluster)
- EKS worker nodes (EC2)
- IAM roles and permissions
- Amazon ECR repositories
- AWS Load Balancer Controller prerequisites
- Terraform remote state backend

---

## Terraform Structure

### Remote State

Terraform uses a remote backend:

- S3 bucket for state storage
- DynamoDB table for state locking

This ensures:

- Safe concurrent usage
- State consistency
- Locking to prevent corruption

---

## Repository Structure

button0-infra/
├── bootstrap/
│ └── state/
└── environments/
└── dev/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── ecr.tf
└── versions.tf


Each environment is isolated and can be created or destroyed independently.

---

## Deploying Infrastructure (Dev)

Prerequisites:
- AWS CLI configured
- Valid AWS credentials

Steps:

cd environments/dev
terraform init
terraform plan
terraform apply


This provisions:

- VPC and networking
- EKS cluster
- Worker nodes
- IAM roles
- ECR repositories

---

## Destroying Infrastructure Safely

Destroying EKS infrastructure may take time due to managed AWS dependencies.

Recommended process:

1. Remove Kubernetes workloads (via ArgoCD)
2. Ensure no ALBs or ENIs remain
3. Run:

terraform destroy


If dependency errors occur, manually clean leftover AWS resources and re-run Terraform.

This behavior is expected with managed cloud services.

---

## Scope Boundaries

This repository does NOT:

- Deploy application code
- Manage Kubernetes manifests
- Handle CI/CD pipelines

Those concerns are handled in separate repositories.

---

## Summary

This repository provides the cloud foundation for Button0.

It demonstrates:

- Infrastructure as Code
- AWS best practices
- Kubernetes provisioning
- Environment lifecycle management
