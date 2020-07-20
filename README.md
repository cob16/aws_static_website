# A static website
A cloudfront hosted website that uses a private s3 backend
```
                    +------+       +--------------+      +------+
                    |      |       |              |      |      |
                    | DNS  | +---> |  CloudFront  | +--> |  S3  |
                    |      |       |              |      |      |
                    +------+       +--------------+      +------+
```

On a AWS free account this will cost arround $0.60 per month (not including domain registration)

# Perquisites
- Terraform (+v0.12)
- An AWS account

# Setup
- Remove line 8 in `main.tf` `backend.s3` 
- copy the example tfvars file and edit
```bash
cp example.tvars terraform.tfvars
```
- edit `terraform.tfvars` to fit your needs 

Note: The descriptions of`variables.tf` can give you hints

