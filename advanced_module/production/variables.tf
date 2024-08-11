locals {
  environment = "production"
  vpc_cidr = "10.1.0.0/16"
  public_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
  availability_zones = ["ap-northeast-1a", "ap-northeast-1c"]
  instances = {
    type = "t2.micro"
    desired_capacity_size = 2
    min_size = 2
    max_size = 3
  }
}
