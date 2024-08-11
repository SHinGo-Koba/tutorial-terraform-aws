output "autoscaling_group_name" {
  description = "The name of the autoscaling group"
  value       = aws_autoscaling_group.asg.name
}

output "launch_template_id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.lt.id
}
