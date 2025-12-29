#!/usr/bin/env bash
set -euo pipefail

: "${AWS_REGION:?AWS_REGION is required}"
: "${ECR_REPO_URI:?ECR_REPO_URI is required}"

ACCOUNT_ID="$(echo "$ECR_REPO_URI" | cut -d'.' -f1)"
aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
