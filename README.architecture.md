# Button0 – Cloud Architecture Details

## High-Level Architecture

Internet
|
Internet Gateway
|
Application Load Balancer (ALB)
|
EKS Ingress Controller
|
Kubernetes Services
|
Pods (Frontend / Backend)

---

## Networking (VPC)

A dedicated VPC is created for the project to isolate all resources.

Inside the VPC:

### Public Subnets
- Host the Application Load Balancer
- Route traffic through the Internet Gateway

### Private Subnets
- Host EKS worker nodes
- No direct internet exposure

This separation improves security and follows AWS best practices.

---

## Internet Gateway

An Internet Gateway (IGW) is attached to the VPC to allow:

- Incoming traffic to the ALB
- Outgoing traffic from public-facing components

Worker nodes remain private and are not directly exposed.

---

## Amazon EKS (Kubernetes)

EKS is used for container orchestration.

Responsibilities include:

- Pod scheduling
- Self-healing
- Service discovery
- Integration with AWS load balancing

The Kubernetes control plane is fully managed by AWS.

---

## Worker Nodes (EC2)

EKS worker nodes are created using managed Node Groups.

Characteristics:

- EC2 instances in private subnets
- Pull images from Amazon ECR
- Authenticate using IAM roles

Instance types are chosen for:
- Cost efficiency
- Development workloads
- Kubernetes compatibility

---

## IAM (Identity and Access Management)

IAM roles are created for:

- EKS control plane
- EKS worker nodes
- AWS Load Balancer Controller

Permissions follow the principle of least privilege.
No credentials are hardcoded.

---

## Amazon ECR (Elastic Container Registry)

Two repositories are created:

- button0-frontend
- button0-backend

These repositories store Docker images built by CI pipelines.

Kubernetes pulls images securely using IAM-based authentication.

---

## AWS Load Balancer Controller

The AWS Load Balancer Controller enables:

- Automatic ALB creation
- Kubernetes Ingress integration
- AWS-managed health checks

This removes the need for manual load balancer configuration.

---

## Known Challenges and Lessons Learned

- EKS teardown can fail due to leftover dependencies
- Managed AWS resources may outlive Terraform state
- ALBs and ENIs can block VPC deletion
- Manual cleanup is sometimes required

These are real-world DevOps challenges and expected learning points.

---

## Why Terraform Was Chosen

Terraform was selected because it:

- Is industry standard
- Supports modular, reusable infrastructure
- Enables full lifecycle management
- Encourages clean architecture
- Works well with AWS and Kubernetes
