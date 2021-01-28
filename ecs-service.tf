resource "aws_ecs_service" "nginx" {
  name            = "nginx"
  cluster         = "my-cluster"
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = 2
}