provider "aws" {
  alias  = "network"
  region = "eu-west-1"
  assume_role {
    role_arn = "arn:aws:iam::<NETWORK_ACCOUNT_ID>:role/GitHubActionsRole"
  }
}

provider "aws" {
  alias  = "prod"
  region = "eu-west-1"
  assume_role {
    role_arn = "arn:aws:iam::<PROD_ACCOUNT_ID>:role/GitHubActionsRole"
  }
}
