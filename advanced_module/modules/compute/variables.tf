variable "instance_type" {
  description = "The instance type of the EC2 instances"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs to launch resources in"
}

variable "security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to associate with"
}

variable "user_data" {
  description = "The user data to provide when launching the instances"
  default     = ""
}

variable "environment" {
  description = "The environment in which the instances are deployed"
}

variable "desired_capacity" {
  description = "The desired number of instances for the autoscaling group"
}

variable "min_size" {
  description = "The minimum size of the autoscaling group"
}

variable "max_size" {
  description = "The maximum size of the autoscaling group"
}

variable "target_group_arn" {
  description = "The ARN of the target group to associate with the autoscaling group"
}
