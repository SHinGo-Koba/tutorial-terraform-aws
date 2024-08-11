variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
}

variable "public_subnets_cidr" {
  description = "A list of public subnet CIDR blocks"
  type        = list(string)
}

variable "availability_zones" {
  description = "A list of availability zones in the region"
  type        = list(string)
}

variable "environment" {
  description = "The environment in which resources are deployed"
}
