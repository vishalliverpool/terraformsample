variable "cidrblock_vpc" {
  default = "10.0.0.0/26"
}

variable "cidrblock_private" {
    default = "10.0.0.32/28"
}
variable "cidrblock_public_1" {
    default = "10.0.0.0/28"
}

variable "lb_cidr_01" {
default = "10.0.0.16/28"
}
variable "lb_cidr_02" {
default = "10.0.0.48/28"
}
variable "ecs_cluster" {
  description = "ECS cluster name"
}

variable "ecs_key_pair_name" {
  description = "ECS key pair name"
}
variable "availability_zone" {
  description = "availability zone used for the demo, based on region"
  default = {
    us-east-1 = "us-east-1"
  }
}

variable "max_instance_size" {
  description = "Maximum number of instances in the cluster"
}

variable "min_instance_size" {
  description = "Minimum number of instances in the cluster"
}

variable "desired_capacity" {
  description = "Desired number of instances in the cluster"
}
