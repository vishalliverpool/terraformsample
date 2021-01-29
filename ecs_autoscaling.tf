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

# Attach an autoscaling policy to the spot cluster to target 50% MemoryReservation on the ECS cluster.
resource "aws_autoscaling_policy" "ecs_cluster_scale_policy" {
  name = "my-cluster"
  policy_type = "TargetTrackingScaling"
  adjustment_type = "ChangeInCapacity"
  lifecycle {
    ignore_changes = [
      adjustment_type
    ]
  }
  autoscaling_group_name = aws_autoscaling_group.ecs-autoscaling-group.name

  target_tracking_configuration {
    customized_metric_specification {
      metric_dimension {
        name = "ClusterName"
        value = "my-cluster"
      }
      metric_name = "MemoryReservation"
      namespace = "AWS/ECS"
      statistic = "Average"
    }
    target_value = 50.0
  }
}

