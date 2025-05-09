terraform {
  backend "s3" {
    bucket         = "tf-state-geewizaws-global"
    key            = "global/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "tf-locks"
  }
}