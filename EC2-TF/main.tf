data "aws_availability_zones" "available" {}


resource "aws_instance" "firstdemo" {
  
  ami = "${lookup(var.ami_type, var.region)}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  vpc_security_group_ids = "${var.sgs}"
  instance_type = "${lookup(var.instance_type, var.env)}"

  tags = {
      Name = "demoinstance"
  }
}
