# Flask CI/CD: Jenkins → Docker → AWS ECR → EC2 Deploy (Interview-Strong)

This repository demonstrates an end-to-end **CI/CD pipeline** for a Python Flask API:
- Code in GitHub
- Jenkins builds + tests + scans + packages as a Docker image
- Image is pushed to **AWS ECR**
- Jenkins deploys to **AWS EC2** via SSH and runs the container

> ✅ **Hard rule:** the deployment uses *immutable images* (tagged with commit SHA) and a simple zero-downtime approach.

## Architecture

```
Developer → GitHub push
        → Jenkins pipeline (webhook)
            → Lint + Unit Tests + Security checks
            → Build Docker image
            → Push to AWS ECR
            → SSH to EC2
                → Pull image from ECR
                → Run container (healthcheck)
                → Swap traffic (compose update)
```

## Repo Structure
- `app/` Flask API
- `tests/` Pytest unit tests
- `Dockerfile` production container
- `docker-compose.yml` local run
- `Jenkinsfile` full CI/CD pipeline
- `infra/terraform/` IaC to provision EC2 + Security Group + IAM role
- `scripts/` helper scripts for ECR login, deploy, and smoke tests

## Prerequisites
- macOS with: `python3`, `docker`, `awscli`, `terraform`, `git`
- AWS account with permissions to create: ECR, EC2, IAM
- Jenkins (local Docker Jenkins or EC2 Jenkins) with:
  - Docker access
  - AWS credentials (as Jenkins credentials)
  - SSH private key to EC2 (as Jenkins credentials)

## 1) Local run
```bash
cd app
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
python run.py
# open http://localhost:5000/health
```

Or via Docker:
```bash
docker compose up --build
```

## 2) Provision AWS (Terraform)
```bash
cd infra/terraform
terraform init
terraform apply
```

Terraform outputs:
- EC2 public IP
- ECR repository URI

## 3) Configure Jenkins Credentials
Create these Jenkins credentials:
- `aws_access_key_id` and `aws_secret_access_key` (or use IAM role if Jenkins is on AWS)
- `ec2_ssh_key` (SSH private key)
- `ec2_host` (EC2 public IP or DNS)
- `ecr_repo_uri` (e.g., `123456789012.dkr.ecr.us-east-1.amazonaws.com/flask-cicd`)

Also set environment variables in Jenkins job:
- `AWS_REGION` (example: `us-east-1`)

## 4) Pipeline behavior (high level)
Stages:
1. **Checkout**
2. **Install & Lint** (flake8)
3. **Unit Tests** (pytest)
4. **Security** (pip-audit + trivy image scan)
5. **Build Image** (tag with commit SHA)
6. **Push to ECR**
7. **Deploy to EC2** (pull + restart via compose)
8. **Smoke Test**

## Screenshots checklist (add to README once you run it)
- Jenkins pipeline stages (green)
- ECR image tags with commit SHA
- EC2 running container (`docker ps`)
- Smoke test output

## Notes for interview
- Uses commit SHA tags (traceable deployments)
- Includes basic supply chain checks (pip-audit + trivy)
- Health endpoint + container healthcheck
- Infrastructure-as-Code (Terraform)

---

**Author:** Manthan Panchal  
**GitHub:** https://github.com/manthannovember95-pixel
