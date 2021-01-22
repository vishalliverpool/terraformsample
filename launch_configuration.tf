data "template_file" "user_data" {
template = file("/ECS_terraform/userdata.tpl")
}


resource "aws_launch_configuration" "ecs-launch-configuration" {
name = "ecs-launch-configuration"
image_id = "ami-0dc161e2e5f144ffc"
instance_type = "t2.medium"
iam_instance_profile = aws_iam_instance_profile.ecs-instance-profile.name
security_groups      = [aws_security_group.allow_ssh.id]
root_block_device {
volume_type = "standard"
volume_size = 100
delete_on_termination = true
}

lifecycle {
create_before_destroy = true
}

associate_public_ip_address = "true"
key_name = var.ecs_key_pair_name


# register the cluster name with ecs-agent which will in turn coord
# with the AWS api about the cluster

user_data = data.template_file.user_data.rendered
}
