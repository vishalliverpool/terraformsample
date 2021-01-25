resource "aws_autoscaling_group" "ecs-autoscaling-group" {
    name                        = "ecs-autoscaling-group"
    max_size                    = var.max_instance_size
    min_size                    = var.min_instance_size
    desired_capacity            = var.desired_capacity
    vpc_zone_identifier         = [aws_subnet.public.id]
    launch_configuration        = aws_launch_configuration.ecs-launch-configuration.name
    health_check_type           = "EC2"

tags = [
    {
      key                 = "Name"
      value               = "my-cluster"
      propagate_at_launch = true
    }
]
}
