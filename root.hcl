# local backend configuration
# generate "backend" {
#   path      = "backend.tf"
#   if_exists = "overwrite_terragrunt"
#   contents = <<EOF
# terraform {
#   backend "local" {
#     path = ".terraform_backend/terraform.tfstate"
#   }
# }
# EOF
# }

# remote backend configuration
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "${get_env("S3_BUCKET_NAME")}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${get_env("S3_BUCKET_REGION")}"
    # dynamodb_table = "my-lock-table"
    # encrypt        = true
  }
}

# Snowflake provider configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "2.0.0"
    }
  }
}

provider "snowflake" {
  alias = "accountadmin"
  role  = "ACCOUNTADMIN"
}
EOF
}