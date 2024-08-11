variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "A list of public subnet CIDR blocks"
}

variable "availability_zones" {
  type        = list(string)
  description = "A list of availability zones in the region"
}

variable "environment" {
  description = "The environment in which resources are deployed"
}
