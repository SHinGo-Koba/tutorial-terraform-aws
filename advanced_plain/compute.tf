locals {
  ami_id = "ami-03d25459ad01ac2b9" # Amazon Linux 2 AMI 64-bit (x86)
  user_data = base64encode(<<EOF
    #!/bin/bash
    sudo amazon-linux-extras install nginx1
    sudo systemctl enable nginx
    sudo systemctl start nginx.service
  EOF
  )
}

resource "aws_launch_template" "plain" {
  name_prefix   = "lt-${local.environment}-"
  image_id      = local.ami_id
  instance_type = local.instances.type

  vpc_security_group_ids = aws_security_group.ec2[*].id
  user_data              = local.user_data

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "Instance-${local.environment}"
      Environment = local.environment
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "plain" {
  name_prefix         = "asg-${local.environment}-"
  desired_capacity    = local.instances.desired_capacity_size
  max_size            = local.instances.max_size
  min_size            = local.instances.min_size
  vpc_zone_identifier = aws_subnet.public[*].id

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.plain.id
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
    value               = "ASG-Instance-${local.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = local.environment
    propagate_at_launch = true
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true
  wait_for_capacity_timeout = "0"
}

resource "aws_autoscaling_attachment" "compute" {
  autoscaling_group_name = aws_autoscaling_group.plain.name
  lb_target_group_arn    = aws_lb_target_group.compute.arn
}
