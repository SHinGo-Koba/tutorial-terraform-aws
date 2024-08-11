variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be created"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs for the ALB"
}

variable "security_group_id" {
  description = "The ID of the security group attached to the ALB"
}

variable "environment" {
  description = "The environment in which the ALB is deployed"
}
