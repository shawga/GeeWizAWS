terraform {
  backend "s3" {
    bucket         = "tf-state-your-org"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "tf-locks"
    encrypt = true
  }
}

provider "aws" {
  region     = var.aws_region
  assume_role {
    role_arn = var.assume_role_arn  # e.g. arn:aws:iam::111111111111:role/GitHubActionsRole
  }
}
