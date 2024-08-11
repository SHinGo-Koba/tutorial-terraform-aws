module "data" {
  source      = "../modules/data"
}

module "network" {
  source             = "../modules/network"
  vpc_cidr           = local.vpc_cidr
  public_subnets_cidr = local.public_subnets
  availability_zones = local.availability_zones
  environment        = local.environment
}

module "security" {
  source      = "../modules/security"
  vpc_id      = module.network.vpc_id
  environment = local.environment
}

module "alb" {
  source            = "../modules/alb"
  vpc_id            = module.network.vpc_id
  subnet_ids        = module.network.public_subnets_ids
  security_group_id = module.security.alb_sg_id
  environment       = local.environment
}

module "ec2" {
  source             = "../modules/ec2"
  ami_id             = module.data.ami_id
  instance_type      = local.instances.type
  subnet_ids         = module.network.public_subnets_ids
  security_group_ids = [module.security.ec2_sg_id]
  user_data          = file("${path.module}/../modules/ec2/launch_templates/nginx.sh")
  environment        = local.environment
  desired_capacity   = local.instances.desired_capacity_size
  min_size           = local.instances.min_size
  max_size           = local.instances.max_size
  target_group_arn   = module.alb.target_group_arn
}
