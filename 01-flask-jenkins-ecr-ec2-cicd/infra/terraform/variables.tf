variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "ecr_repo_name" {
  type    = string
  default = "flask-cicd"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ec2_key_name" {
  description = "Name of an existing EC2 key pair in your AWS account"
  type        = string
}

variable "my_ip_cidr" {
  description = "Your public IP in CIDR format, e.g. 1.2.3.4/32 for SSH/app access"
  type        = string
}
