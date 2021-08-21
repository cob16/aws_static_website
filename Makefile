config-pull:
	AWS_PAGER="" aws ssm get-parameter \
		--name "terraform.tfvars" \
		--with-decryption \
		--query "Parameter.Value" \
		--output text \
		> terraform.tfvars
	AWS_PAGER="" aws ssm get-parameter \
		--name "backend.hcl" \
		--with-decryption \
		--query "Parameter.Value" \
		--output text \
		> backend.hcl
config-push:
	AWS_PAGER="" aws ssm put-parameter \
		--name "backend.hcl" \
		--type "String" \
		--value file://backend.hcl \
		--overwrite
	AWS_PAGER="" aws ssm put-parameter \
		--name "terraform.tfvars" \
		--type "SecureString" \
		--value file://terraform.tfvars \
		--overwrite

