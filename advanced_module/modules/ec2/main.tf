resource "aws_launch_template" "lt" {
  name_prefix   = "lt-${var.environment}-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = var.security_group_ids
  user_data = base64encode(var.user_data)

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "Instance-${var.environment}"
      Environment = var.environment
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name_prefix = "asg-${var.environment}-"
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size
  vpc_zone_identifier = var.subnet_ids

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.lt.id
        version            = "$Latest"
      }
    }
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  tag {
    key                 = "Name"
    value               = "ASG-Instance-${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  health_check_type          = "EC2"
  health_check_grace_period  = 300
  force_delete               = true
  wait_for_capacity_timeout  = "0"
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn    = var.target_group_arn
}
