# ASG with Launch template
resource "aws_launch_template" "ec2_launch_templ" {
  name_prefix   = "ec2_launch_templ"
  image_id      = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  user_data     = filebase64("userdata.tp1")

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = aws_subnet.private_subnet_1.id
    security_groups             = [aws_security_group.ec2_sg.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "instances" # Name for the EC2 instances
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  # no of instances
  desired_capacity = 1
  max_size         = 1
  min_size         = 1

  # Connect to the target group
  target_group_arns = [aws_lb_target_group.alb_tg.arn]

  vpc_zone_identifier = [ # Creating EC2 instances in private subnet
    aws_subnet.private_subnet_1.id
  ]

  launch_template {
    id      = aws_launch_template.ec2_launch_templ.id
    version = "$Latest"
  }
}
