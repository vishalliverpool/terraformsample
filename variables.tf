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
}
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