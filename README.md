# Terraform EC2 on Default VPC (t3.micro)

This project creates a single EC2 instance in the **default VPC** (us-east-1) using Terraform.
Instance type is **t3.micro** (free-tier eligible).

## Files
- provider.tf        : provider & required_providers
- variables.tf       : region, instance_type, ami_id
- data-sources.tf    : fetch default VPC & subnets
- security-group.tf  : security group allowing SSH & HTTP
- main.tf            : aws_instance resource
- outputs.tf         : useful outputs
- terraform.tfvars   : default variable overrides
- .github/workflows/terraform.yml : GitHub Actions workflow

## Usage (local)
1. Configure AWS credentials: `aws configure` or set env vars.
2. Initialize Terraform:
   ```
   terraform init
   terraform validate
   terraform plan -var-file="terraform.tfvars"
   terraform apply -var-file="terraform.tfvars" -auto-approve
   ```
3. Destroy:
   ```
   terraform destroy -var-file="terraform.tfvars" -auto-approve
   ```

## Usage (CI via GitHub Actions)
1. Push repo to GitHub main branch.
2. Add repository secrets: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION`.
3. Workflow runs and deploys automatically.

