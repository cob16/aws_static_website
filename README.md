# A static website
On a AWS free account this will cost around $0.60 per month (not including domain registration)

A cloudfront hosted website that uses a private s3 backend
```
                    +------+       +--------------+      +------+
                    |      |       |              |      |      |
                    | DNS  | +---> |  CloudFront  | +--> |  S3  |
                    |      |       |              |      |      |
                    +------+       +--------------+      +------+
```

## And some monitoring 
Cloudwatch billing and usage alerts to pager duty based of customisable thresholds
```
                    +------------+       +-------+      +-------------+
                    |            |       |       |      |             |
                    | Cloudwatch | +---> |  SNS  | +--> |  Pagerduty  |
                    |            |       |       |      |             |
                    +------------+       +-------+      +-------------+
```

# Prerequisities
- Terraform (+v0.12)
- An AWS account (free tier)
- Pagerduty account (free tier)

# Setup
- Remove line 8 in `main.tf` `backend.s3` 
- copy the example tfvars file and edit
```bash
cp example.tfvars terraform.tfvars
```
- edit `terraform.tfvars` to fit your needs 

Note: The descriptions of`variables.tf` can give you hints

