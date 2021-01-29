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

# scale out alarm policy

resource "aws_autoscaling_policy" "test-memory-policy-scaleout" {
name = "example-memory-policy-scaleout"
autoscaling_group_name = aws_autoscaling_group.ecs-autoscaling-group.name
adjustment_type = "ChangeInCapacity"
scaling_adjustment = "1"
cooldown = "300"
policy_type = "SimpleScaling"
}

# scaleout-cloud metric

resource "aws_cloudwatch_metric_alarm" "example-memory-alarm" {
alarm_name = "example-memory-alarm-scaleout"
alarm_description = "example-memory-scaleout"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods = "2"
metric_name = "MemoryReservation"
namespace = "AWS/ECS"
period = "120"
statistic = "Average"
threshold = "70"
dimensions = {
AutoScalingGroupName = aws_autoscaling_group.ecs-autoscaling-group.name
}
actions_enabled = true
alarm_actions = [aws_autoscaling_policy.test-memory-policy-scaleout.arn]
}


# scale in alarm

resource "aws_autoscaling_policy" "test-memory-policy-scalein" {
name = "example-memory-policy-scaledown"
autoscaling_group_name = aws_autoscaling_group.ecs-autoscaling-group.name
adjustment_type = "ChangeInCapacity"
scaling_adjustment = "-1"
cooldown = "300"
policy_type = "SimpleScaling"
}

#scalein metric

resource "aws_cloudwatch_metric_alarm" "example-memory-alarm-scalein" {
alarm_name = "example-memory-alarm-scalein"
alarm_description = "example-memory-alarm-scalein"
comparison_operator = "LessThanOrEqualToThreshold"
evaluation_periods = "2"
metric_name = "MemoryReservation"
namespace = "AWS/ECS"
period = "120"
statistic = "Average"
threshold = "40"
dimensions = {
AutoScalingGroupName = aws_autoscaling_group.ecs-autoscaling-group.name
}
actions_enabled = true
alarm_actions = [aws_autoscaling_policy.test-memory-policy-scalein.arn]
}