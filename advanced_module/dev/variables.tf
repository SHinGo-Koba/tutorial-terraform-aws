locals {
  environment = "dev"
  vpc_cidr = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones = ["ap-northeast-1a", "ap-northeast-1c"]
  instance_type = "t2.micro"
}
