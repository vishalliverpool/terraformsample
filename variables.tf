variable "cidrblock" {
  type = map
  default = {
   vpc="10.0.0.0/26"
   private = "10.0.0.32/28"
   public= "10.0.0.0/28"
}
}
variable "availability_zone" {
  description = "availability zone used for the demo, based on region"
  default = {
    us-east-1 = "us-east-1"
  }
}