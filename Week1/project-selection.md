# Project Selection

## Internship Program

**Program:** DevOps Engineering Self-Learning Internship  
**Duration:** 6 Weeks  
**Repository:** ICP-3F5078D1-2026-REPO

## Selected Projects

### Project 7 — Infrastructure as Code

**Level:** Advanced  
**Primary Technology:** Terraform

This project focuses on defining and managing AWS infrastructure as code.

The implementation will emphasize:

- Terraform configuration
- Modular infrastructure
- Variables and outputs
- Remote state management
- State locking
- IAM
- AWS networking
- Amazon ECR
- Security best practices
- Infrastructure validation
- Infrastructure testing
- Reproducible deployment

### Project 8 — GitOps Workflow

**Level:** Advanced  
**Primary Technology:** ArgoCD

This project focuses on implementing a GitOps deployment workflow using a local Kubernetes environment.

The implementation will emphasize:

- Git as the source of truth
- Kubernetes
- ArgoCD
- Automated synchronization
- Configuration drift detection
- Deployment rollback
- Version-controlled application configuration

## Integrated Project

The two projects will be integrated into:

**Production-Ready AWS Infrastructure & Local Kubernetes GitOps Platform**

Terraform will provision and manage the required AWS infrastructure.

A local Kubernetes cluster will be used for Kubernetes and ArgoCD development and testing in order to minimize cloud infrastructure costs.

ArgoCD will manage Kubernetes application deployments using Git as the source of truth.

## Cost Optimization Strategy

The project will avoid maintaining an always-running managed Kubernetes cluster in AWS.

The development Kubernetes environment will run locally using WSL2 and container-based Kubernetes tooling.

AWS resources will be limited to infrastructure required to demonstrate Infrastructure as Code and cloud integration.

Temporary cloud resources will be created only when required for testing and will be destroyed when no longer needed.

The project will also avoid unnecessary high-cost infrastructure such as continuously running Kubernetes control planes, worker nodes, and NAT gateways.

## Project Objective

The objective is to demonstrate a production-oriented DevOps workflow that is:

- Automated
- Reproducible
- Version controlled
- Secure
- Observable
- Cost conscious
- Maintainable

The project will combine Infrastructure as Code, CI/CD, containerization, Kubernetes, GitOps, security scanning, monitoring, testing, and operational documentation.

## Expected Outcome

At the end of the internship, the repository will demonstrate:

1. AWS infrastructure provisioned using Terraform.
2. Modular and reusable infrastructure configuration.
3. Remote Terraform state management.
4. Secure handling of sensitive configuration.
5. Containerized application deployment.
6. Kubernetes application deployment.
7. ArgoCD GitOps synchronization.
8. Configuration drift detection.
9. Deployment rollback.
10. CI/CD automation through GitHub Actions.
11. Container and infrastructure security scanning.
12. Monitoring and logging.
13. Failure and recovery testing.
14. Complete deployment and troubleshooting documentation.
