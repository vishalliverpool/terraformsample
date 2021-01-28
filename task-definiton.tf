data "template_file" "conatiner-definiton" {
  template = file(format("./task-definitions/nginx.tpl"))
  vars = {
    image         = var.image
    memory        = var.memory
    cpu           = var.cpu
    name          = var.name
  }
}

resource "aws_ecs_task_definition" "nginx" {
  family = "nginx"
  container_definitions = data.template_file.conatiner-definiton.rendered
}
