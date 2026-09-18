# System Architecture

## Project

Production-Ready AWS Infrastructure & Local Kubernetes GitOps Platform

---

## 1. Architecture Overview

This project implements a DevOps platform combining Infrastructure as Code, containerization, CI/CD, Kubernetes, GitOps, security scanning, and observability.

The architecture is designed to demonstrate production-oriented DevOps practices while minimizing unnecessary cloud infrastructure costs.

AWS will be used for selected cloud infrastructure components, while Kubernetes and ArgoCD will run locally in the WSL2 development environment.

---

## 2. Architecture Components

### 2.1 GitHub

GitHub serves as the central version-control platform and source of truth for infrastructure, application, and Kubernetes configuration.

The repository will contain:

- Application source code
- Terraform configuration
- Kubernetes manifests
- GitHub Actions workflows
- Documentation
- Testing configuration

### 2.2 Terraform

Terraform implements the Infrastructure as Code layer.

It will provision and manage selected AWS resources using version-controlled configuration.

Terraform will be used to demonstrate:

- Infrastructure provisioning
- Modular infrastructure
- Variables
- Outputs
- Remote state management
- State locking
- Infrastructure validation
- Reproducible deployments

### 2.3 AWS

AWS provides the cloud infrastructure required by the project.

Planned components include:

- Amazon VPC
- AWS IAM
- Amazon ECR
- Amazon S3 for Terraform state

Additional AWS resources will only be introduced when they provide clear project value.

### 2.4 Docker

Docker packages the application and its dependencies into a portable container image.

The container image will provide a consistent application environment for development, testing, and deployment.

### 2.5 Kubernetes

A local Kubernetes environment will be used for application orchestration and GitOps development.

Kubernetes will run locally through the WSL2 development environment.

This approach avoids the recurring cost of maintaining an always-running managed Kubernetes cluster in AWS.

Kubernetes will manage:

- Application workloads
- Services
- Configuration
- Health checks
- Resource limits
- Application availability

### 2.6 ArgoCD

ArgoCD implements the GitOps deployment layer.

It will monitor Kubernetes configuration stored in Git and synchronize the desired configuration with the local Kubernetes environment.

ArgoCD will be used to demonstrate:

- Git as the source of truth
- Automated synchronization
- Configuration drift detection
- Deployment management
- Rollback strategies

### 2.7 GitHub Actions

GitHub Actions provides CI/CD automation.

The pipeline will perform tasks such as:

- Application testing
- Terraform formatting
- Terraform validation
- Terraform security checks
- Docker image building
- Container image scanning
- Deployment-related automation

### 2.8 Trivy

Trivy will be used for security scanning.

It will be used to scan:

- Container images
- Infrastructure configuration
- Potential security vulnerabilities

Security scanning will be integrated into the CI/CD workflow.

### 2.9 Prometheus

Prometheus will collect application and Kubernetes metrics.

It will provide metrics that can be used to understand the health and performance of the application and Kubernetes environment.

### 2.10 Grafana

Grafana will provide dashboards for visualizing monitoring data collected from Prometheus.

The monitoring environment will be used to demonstrate:

- Application health
- Resource utilization
- Kubernetes workload status
- Operational visibility

---

## 3. High-Level Architecture

The overall architecture follows this workflow:

```text
                         DEVELOPER
                             |
                             | git push
                             v
                    +------------------+
                    |     GitHub       |
                    |                  |
                    | Application Code |
                    | Terraform Code   |
                    | K8s Manifests    |
                    +--------+---------+
                             |
                +------------+------------+
                |                         |
                v                         v
       +------------------+      +------------------+
       | GitHub Actions   |      |    Terraform     |
       |                  |      |                  |
       | Testing          |      | Infrastructure   |
       | Security Scans   |      | as Code          |
       | Docker Build     |      +--------+---------+
       +--------+---------+               |
                |                         v
                v                        AWS
             Docker                 +-----+-----+
                |                   |     |     |
                v                   v     v     v
          Container Image          VPC   IAM   ECR
                |
                v
       +----------------------+
       | Local Kubernetes     |
       |                      |
       |       ArgoCD         |
       |          |           |
       |          v           |
       |    Application       |
       +----------+-----------+
                  |
                  v
             Prometheus
                  |
                  v
               Grafana
## 4. High-Level Workflow

The development and deployment workflow is:

1. A developer makes a change to the application or infrastructure.
2. The change is committed to Git.
3. The repository is pushed to GitHub.
4. GitHub Actions automatically runs configured validation and security checks.
5. The application is packaged into a Docker container.
6. The container image is scanned for vulnerabilities.
7. Terraform manages the required AWS infrastructure.
8. Kubernetes runs the application locally.
9. ArgoCD monitors the Git repository.
10. ArgoCD synchronizes Kubernetes with the desired state stored in Git.
11. Prometheus collects metrics.
12. Grafana provides monitoring dashboards.
13. Deployment failures and rollback scenarios are tested and documented.

---

## 5. GitOps Workflow

Git serves as the source of truth for the desired Kubernetes application state.

The GitOps workflow is:

```text
Developer
    |
    v
GitHub
    |
    v
Kubernetes Manifests
    |
    v
ArgoCD
    |
    v
Local Kubernetes
    |
    v
Application
```

ArgoCD will continuously compare the desired state stored in Git with the state of the Kubernetes environment.

When configuration changes are committed, ArgoCD can synchronize the environment according to the configured GitOps policy.

This approach allows deployment configuration to be version controlled and provides a clear history of configuration changes.

---

## 6. Infrastructure as Code Workflow

Terraform will manage the selected AWS infrastructure.

The workflow is:

```text
Terraform Configuration
          |
          v
   Terraform Format
          |
          v
   Terraform Validate
          |
          v
     Terraform Plan
          |
          v
        Review
          |
          v
    Terraform Apply
          |
          v
   AWS Infrastructure
```

Infrastructure configuration will be stored in Git and designed to be reproducible.

Changes to infrastructure will be reviewed before being applied where appropriate.

---

## 7. CI/CD Workflow

GitHub Actions will automate validation and application build processes.

The planned workflow is:

```text
Git Push
   |
   v
GitHub Actions
   |
   +----> Test Application
   |
   +----> Terraform Format Check
   |
   +----> Terraform Validate
   |
   +----> Security Scan
   |
   +----> Build Docker Image
   |
   +----> Scan Container Image
   |
   v
Pipeline Result
```

A failed validation or security check should prevent the workflow from proceeding to subsequent stages where appropriate.

---

## 8. Security Architecture

Security will be integrated throughout the development lifecycle.

The project will include:

- IAM least-privilege practices
- Secure secret handling
- Container image scanning
- Infrastructure security scanning
- Protection against committing secrets to Git
- Controlled CI/CD permissions
- Version-controlled security configuration
- Regular validation of infrastructure configuration

Sensitive credentials and secrets will not be committed directly to the Git repository.

---

## 9. Cost Optimization

The architecture intentionally avoids maintaining an always-running managed Kubernetes cluster.

Kubernetes and ArgoCD will run locally during development and testing.

AWS resources will be limited to components required to demonstrate cloud infrastructure management and integration.

Temporary cloud resources will be created only when required for testing.

Resources that are no longer required will be destroyed to reduce unnecessary costs.

The project will avoid unnecessary continuously running infrastructure such as:

- Managed Kubernetes control planes
- Dedicated Kubernetes worker nodes
- NAT gateways where they are not required

Cost will be treated as an infrastructure design consideration throughout the project.

---

## 10. Reliability and Recovery

The project will include deliberate failure testing and recovery procedures.

The following scenarios will be considered.

### 10.1 Invalid Infrastructure Configuration

```text
Invalid Terraform
       |
       v
Terraform Validation
       |
       v
Pipeline Failure
       |
       v
Fix Configuration
```

### 10.2 Vulnerable Container

```text
Docker Image
     |
     v
   Trivy
     |
     v
Vulnerability Detected
     |
     v
Pipeline Blocked
```

### 10.3 Kubernetes Deployment Failure

```text
Application Change
       |
       v
Kubernetes Deployment
       |
       v
Health Check Failure
       |
       v
Investigation
       |
       v
Fix / Rollback
```

### 10.4 GitOps Rollback

```text
Application Version 1
       |
       v
Deployment
       |
       v
Application Version 2
       |
       v
Problem Detected
       |
       v
Git Revert
       |
       v
ArgoCD Synchronization
       |
       v
Application Version 1
```

The results of failure and recovery tests will be documented in the project repository.

---

## 11. Observability

The project will include monitoring and operational visibility.

Prometheus will collect metrics from the application and Kubernetes environment.

Grafana will visualize the collected metrics.

The monitoring implementation will be used to observe:

- Application health
- Kubernetes workload status
- Resource utilization
- Deployment status
- Service availability

Logs and monitoring information will also be used during troubleshooting and failure testing.

---

## 12. Reproducibility

The project will be designed so that another developer can reproduce the environment using the documented procedures.

Configuration will be stored in Git wherever practical.

Manual configuration steps will be documented.

Infrastructure will be defined through Terraform rather than relying on undocumented manual AWS console changes.

Kubernetes application configuration will be stored in Git and managed through the GitOps workflow.

---

## 13. Architecture Goals

The final platform should demonstrate the following DevOps principles:

- Infrastructure as Code
- Version control
- Automation
- Continuous Integration
- Continuous Delivery
- GitOps
- Containerization
- Kubernetes orchestration
- Security integration
- Observability
- Reliability engineering
- Failure testing
- Rollback
- Cost optimization
- Reproducibility

---

## 14. Expected Architecture Outcome

The completed project should demonstrate a complete workflow from source code to infrastructure and application deployment.

The final workflow should resemble:

```text
                    +----------------+
                    |    Developer   |
                    +-------+--------+
                            |
                            v
                    +---------------+
                    |    GitHub     |
                    +-------+-------+
                            |
             +--------------+--------------+
             |                             |
             v                             v
     +---------------+             +---------------+
     | GitHub Actions|             |   Terraform   |
     +-------+-------+             +-------+-------+
             |                             |
             v                             v
        Docker Build                      AWS
             |                       Infrastructure
             v
       Security Scan
             |
             v
      Container Image
             |
             v
    +-------------------+
    | Local Kubernetes  |
    +---------+---------+
              |
              v
            ArgoCD
              |
              v
       GitOps Deployment
              |
              v
         Application
              |
              v
      Prometheus + Grafana
```

The architecture will be implemented progressively throughout the six-week internship.
