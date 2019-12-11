provider "aws" {
  region = "eu-west-1"
}

data "aws_availability_zones" "all-zones" {
  state = "available"
}

resource "aws_security_group" "sec-group-1" {
  name = "sec-group-1"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "sec-group-lb" {
name = "sec-group-lb"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #   ingress {
  #     from_port       = 0
  #     to_port         = 0
  #     protocol        = "-1"
  #     cidr_blocks     = ["0.0.0.0/0"]
  #   }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "load-bal" {
  name               = "load-bal"
  security_groups    = [aws_security_group.sec-group-lb.id]
  availability_zones = data.aws_availability_zones.all-zones.names

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 10
    target              = "HTTP:80/"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = 80
    instance_protocol = "http"
  }
}


resource "aws_launch_configuration" "launch-conf" {
  image_id        = "ami-09c2a99a4327eefde"
  instance_type   = "t2.micro"
  key_name = "AWS"
  security_groups = [aws_security_group.sec-group-1.id]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  launch_configuration = aws_launch_configuration.launch-conf.id
  availability_zones   = data.aws_availability_zones.all-zones.names
  min_size             = 3
  max_size             = 3
  load_balancers       = [aws_elb.load-bal.name]
  health_check_type    = "ELB"
  tag {
    key                 = "name"
    value               = "asg-instance"
    propagate_at_launch = true
  }
}

output "elb_dns_name" {
  value = aws_elb.load-bal.dns_name
}
