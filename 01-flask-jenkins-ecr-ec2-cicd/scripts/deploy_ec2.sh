#!/usr/bin/env bash
set -euo pipefail

: "${EC2_HOST:?EC2_HOST is required}"
: "${EC2_USER:=ubuntu}"
: "${IMAGE_URI:?IMAGE_URI is required}"

# Copies compose file and runs deployment on EC2
ssh -o StrictHostKeyChecking=no "${EC2_USER}@${EC2_HOST}" "mkdir -p ~/flask-cicd"

scp -o StrictHostKeyChecking=no ./infra/ec2/docker-compose.ec2.yml "${EC2_USER}@${EC2_HOST}:~/flask-cicd/docker-compose.yml"

ssh -o StrictHostKeyChecking=no "${EC2_USER}@${EC2_HOST}" bash -lc "'
set -euo pipefail
cd ~/flask-cicd
export IMAGE_URI=${IMAGE_URI}
# Replace image in compose
sed -i.bak "s|IMAGE_URI|${IMAGE_URI}|g" docker-compose.yml
docker compose pull
docker compose up -d
docker image prune -f
'"
