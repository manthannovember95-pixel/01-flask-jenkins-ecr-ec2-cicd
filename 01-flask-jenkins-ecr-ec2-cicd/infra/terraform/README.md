# Terraform (Project 1)

## Steps
1. Create an EC2 Key Pair in AWS (or reuse one)
2. Find your public IP and set it as CIDR (example: `203.0.113.10/32`)
3. Run:
```bash
terraform init
terraform apply -var="ec2_key_name=YOUR_KEYPAIR" -var="my_ip_cidr=YOUR_IP/32"
```
Outputs:
- `ec2_public_ip`
- `ecr_repo_uri`
