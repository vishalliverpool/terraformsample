variable "cidrblock" {
  type = map
  default = {
   vpc_cidr = {
     vpc="10.0.0.0/26"
   } 
   private_subnet = {
    private = "10.0.0.32/28"
  }
   public_subnet = {
     public= "10.0.0.0/28"
 }
 loadbancer_IP01 = {
   loadpublic01= "10.0.0.16/28"
}
loadbancer_IP02 = {
   loadpublic02= "10.0.0.48/28"
}
}
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