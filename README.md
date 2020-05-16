# A static website
A cloudfront hosted website that uses a private s3 backend
```
                    +------+       +--------------+      +------+
                    |      |       |              |      |      |
                    | DNS  | +---> |  CloudFront  | +--> |  S3  |
                    |      |       |              |      |      |
                    +------+       +--------------+      +------+
```

# Perquisites
- Terraform (+v0.12)
- An AWS account

# Setup
- copy the example tfvars file and edit
```bash
cp example.tvars terraform.tfvars
```
- edit `terraform.tfvars` to fit your needs 

Note: The descriptions of`variables.tf` can give you hints

