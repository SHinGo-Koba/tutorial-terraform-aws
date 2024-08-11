output "ami_id" {
  description = "The AMI ID to use for the instances"
  value       = data.aws_ami.latest_amazon_linux.id
}
