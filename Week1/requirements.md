# Project Requirements

## Project

Production-Ready AWS Infrastructure & Local Kubernetes GitOps Platform

---

## 1. Project Overview

The project will demonstrate an automated DevOps workflow for provisioning selected AWS infrastructure and deploying a containerized application to a local Kubernetes environment.

Terraform will be used to define and manage AWS infrastructure as code.

Docker will be used to containerize the application.

Kubernetes will be used as the application orchestration platform.

ArgoCD will implement the GitOps deployment workflow.

Git will serve as the source of truth for application and Kubernetes deployment configuration.

The project is designed to demonstrate production-oriented DevOps practices while minimizing unnecessary cloud infrastructure costs.

---

## 2. Infrastructure Requirements

The infrastructure layer should include selected AWS resources required to demonstrate Infrastructure as Code and cloud integration.

Planned AWS resources include:

- Amazon VPC
- AWS IAM
- Amazon ECR
- Amazon S3 for Terraform remote state

Infrastructure must be:

- Defined as code
- Version controlled
- Reproducible
- Modular where appropriate
- Configurable through variables
- Documented
- Validated before deployment

The project should avoid unnecessary continuously running AWS infrastructure.

Managed Kubernetes infrastructure such as Amazon EKS will not be required for the primary implementation.

---

## 3. Terraform Requirements

Terraform will be used to provision and manage the selected AWS resources.

The Terraform implementation should demonstrate:

- Terraform configuration
- Providers
- Variables
- Outputs
- Modules
- Resource dependencies
- Terraform formatting
- Terraform validation
- Terraform planning
- Terraform state management
- Remote state storage
- State locking where supported
- Infrastructure security validation

Terraform configuration must be stored in Git.

Sensitive values must not be hard-coded into Terraform configuration.

---

## 4. Application Requirements

The platform should deploy a containerized application to Kubernetes.

The application should include:

- Application source code
- Dockerfile
- Container image
- Application configuration
- Health endpoint
- Automated tests where appropriate

The application should be suitable for demonstrating:

- Containerization
- CI/CD
- Kubernetes deployment
- Health checks
- Monitoring
- Failure and recovery testing

---

## 5. Docker Requirements

Docker will be used to package the application and its dependencies.

The Docker implementation should include:

- Dockerfile
- Reproducible image build
- Appropriate base image
- Minimal unnecessary dependencies
- Container health considerations
- Image tagging strategy

The resulting container image should be scanned for vulnerabilities using Trivy.

---

## 6. Kubernetes Requirements

A local Kubernetes environment will be used for application deployment and testing.

The Kubernetes environment will run locally within the WSL2 development environment.

The implementation should include:

- Kubernetes Deployment
- Kubernetes Service
- ConfigMap where appropriate
- Secrets handling where appropriate
- Resource requests
- Resource limits
- Liveness probe
- Readiness probe
- Application configuration

The Kubernetes configuration must be stored in Git.

The project should demonstrate deployment, application health, failure handling, and recovery.

---

## 7. GitOps Requirements

ArgoCD will manage the Kubernetes application deployment.

The GitOps workflow should:

1. Store Kubernetes configuration in Git.
2. Use Git as the source of truth.
3. Allow configuration changes to be committed through Git.
4. Allow ArgoCD to monitor the repository.
5. Synchronize the desired configuration with the local Kubernetes environment.
6. Detect configuration drift.
7. Support deployment rollback.
8. Maintain a version-controlled history of deployment configuration.

---

## 8. CI/CD Requirements

GitHub Actions will provide CI/CD automation.

The pipeline should perform appropriate validation and security checks.

The workflow should include:

1. Source code checkout.
2. Application testing.
3. Terraform formatting check.
4. Terraform validation.
5. Infrastructure security scanning.
6. Docker image build.
7. Container image vulnerability scanning.
8. Appropriate deployment-related validation.

A failed validation or security check should prevent the workflow from proceeding to subsequent stages where appropriate.

---

## 9. Security Requirements

Security must be considered throughout the project lifecycle.

The project should include:

- IAM least-privilege practices
- Secure credential handling
- Secure secret management
- Container image vulnerability scanning
- Infrastructure security scanning
- Protection against committing secrets to Git
- Controlled CI/CD permissions
- Appropriate repository permissions
- Secure Terraform configuration

Sensitive credentials must not be committed to the repository.

Secrets should be provided through appropriate environment variables, secret stores, CI/CD secrets, or Kubernetes secret mechanisms where appropriate.

---

## 10. Reliability Requirements

The platform should include mechanisms that improve application reliability.

These should include:

- Kubernetes health checks
- Liveness probes
- Readiness probes
- Resource requests
- Resource limits
- Deployment validation
- Failure testing
- Recovery procedures
- Rollback procedures

The project should intentionally test selected failure scenarios and document the results.

---

## 11. Observability Requirements

The project should provide visibility into application and Kubernetes behavior.

The monitoring implementation should include:

- Prometheus
- Grafana

The platform should provide visibility into:

- Application health
- Kubernetes workload status
- Resource utilization
- Deployment status
- Service availability
- Application metrics where practical

Monitoring dashboards should be documented.

---

## 12. Testing Requirements

The project should include testing of:

- Application functionality
- Terraform configuration
- Terraform validation
- Infrastructure security configuration
- Docker image build
- Container image security
- Kubernetes manifests
- Kubernetes application deployment
- GitOps synchronization
- Configuration drift
- Rollback procedures
- Failure scenarios
- Recovery procedures

Test results should be documented.

---

## 13. Cost Optimization Requirements

Cost optimization is a core design consideration.

The project should:

- Avoid maintaining an always-running managed Kubernetes cluster.
- Use local Kubernetes for primary development and GitOps testing.
- Avoid unnecessary continuously running AWS resources.
- Avoid unnecessary NAT gateways where they are not required.
- Use temporary cloud resources only when required.
- Destroy temporary resources after testing.
- Monitor AWS resources created by Terraform.

The project should document the reasoning behind major cost-optimization decisions.

---

## 14. Documentation Requirements

The repository should contain documentation covering:

- Project selection
- Requirements
- Architecture
- Environment setup
- Installation
- Configuration
- Terraform deployment
- Docker usage
- Kubernetes deployment
- GitOps workflow
- CI/CD workflow
- Security controls
- Monitoring
- Troubleshooting
- Rollback
- Failure testing
- Recovery procedures
- Operational procedures
- Cost optimization

Documentation should provide enough information for another developer to reproduce the project.

---

## 15. Reproducibility Requirements

Another developer should be able to reproduce the development and deployment environment using the documented procedures.

The project should:

- Store configuration in Git.
- Document required dependencies.
- Document installation procedures.
- Document configuration requirements.
- Minimize undocumented manual steps.
- Use Terraform for AWS infrastructure.
- Use Kubernetes manifests stored in Git.
- Use ArgoCD for GitOps deployment.
- Document testing and recovery procedures.

---

## 16. Failure and Recovery Scenarios

The project should demonstrate deliberate failure testing.

At minimum, the following scenarios should be considered.

### 16.1 Terraform Validation Failure

An intentionally invalid Terraform configuration should be detected during validation.

Expected behavior:

```text
Invalid Terraform
       |
       v
Terraform Validate
       |
       v
Validation Failure
       |
       v
Pipeline Stops
       |
       v
Configuration Fixed
```

### 16.2 Container Vulnerability Detection

A container image should be scanned using Trivy.

Expected behavior:

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
Pipeline Action
```

The project should document how vulnerabilities are investigated and addressed.

### 16.3 Kubernetes Deployment Failure

The project should demonstrate how an unhealthy deployment is detected.

Expected behavior:

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
Fix or Rollback
```

### 16.4 GitOps Rollback

The project should demonstrate recovery from a problematic application version.

Expected behavior:

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

Failure and recovery results must be documented.

---

## 17. Definition of Done

The project will be considered complete when:

- AWS infrastructure can be provisioned using Terraform.
- Terraform configuration is stored in Git.
- Terraform modules are used where appropriate.
- Terraform remote state is configured.
- The application can be built into a Docker image.
- The Docker image can be scanned for vulnerabilities.
- The application can be deployed to local Kubernetes.
- Kubernetes health checks are configured.
- Resource requests and limits are configured.
- ArgoCD manages the application deployment.
- Git changes can trigger the GitOps deployment workflow.
- Configuration drift can be detected.
- A rollback can be demonstrated.
- GitHub Actions performs automated validation.
- Security scanning is integrated into the workflow.
- Prometheus collects relevant metrics.
- Grafana provides monitoring dashboards.
- Failure scenarios are tested.
- Recovery procedures are documented.
- Security controls are documented.
- Cost optimization decisions are documented.
- Deployment procedures are documented.
- Troubleshooting procedures are documented.
- Another developer can reproduce the environment using the documentation.

---

## 18. Expected Outcome

At the end of the internship, the repository should demonstrate an integrated DevOps platform combining:

- Infrastructure as Code
- AWS
- Terraform
- Docker
- Kubernetes
- GitOps
- ArgoCD
- GitHub Actions
- Trivy
- Prometheus
- Grafana
- Automated testing
- Security practices
- Failure testing
- Recovery procedures
- Rollback
- Cost optimization
- Reproducible deployment

The final implementation should demonstrate practical understanding of modern DevOps engineering practices without requiring an always-running managed Kubernetes environment.
