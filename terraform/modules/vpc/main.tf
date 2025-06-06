module "network_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  providers = {
    aws = aws.network
  }

  name = "network-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Environment = "network"
  }
}
