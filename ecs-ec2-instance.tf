resource "aws_instance" "ec2_instance"  {
    ami                         = "ami-0dc161e2e5f144ffc"
    instance_type               = "m5zn.large"
    iam_instance_profile        = aws_iam_instance_profile.ecs-instance-profile.id
    subnet_id                   =  aws_subnet.public.id

    root_block_device {
      volume_type = "standard"
      volume_size = 100
      delete_on_termination = true
    }

    lifecycle {
      create_before_destroy = true
    }

    security_groups             = [aws_security_group.allow_ssh.id]
    associate_public_ip_address = "true"
    key_name                    = var.ecs_key_pair_name
    user_data                   = "#!/bin/bash echo ECS_CLUSTER=my-cluster >> /etc/ecs/ecs.config"
}
