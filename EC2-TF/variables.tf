variable "env" {}

variable "region" {}

variable "ami_type" {
   default = { 
       type = "map" 
       us-east-1 = "ami-0fc61db8544a617ed"
       us-east-2 = "ami-03201f374ab66a26e"
   }
}

variable "instance_type" {
  
  type = "map"

  default = {
      dev = "t2.micro"
      test = "t2.medium"
  }
}



variable "sgs" {
  type = "list"
  default = ["sg-08105894e2c9d3c24", "sg-09e641e1f2e1b3308"]
}

