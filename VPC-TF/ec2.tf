resource "aws_instance" "Webec2" {
  ami                         = "ami-0fc61db8544a617ed"
  instance_type               = "t2.micro"
  subnet_id                   = "${aws_subnet.PublicSN.id}"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.webSG.id}"]
  key_name                    = "cloudformkey"

  tags = {
    Name = "TF-Webserver"
  }
  //depends_on = ["aws_vpc.MainVPC.MainVPC-TF"]
}

resource "aws_instance" "DBec2" {
  ami                         = "ami-0fc61db8544a617ed"
  instance_type               = "t2.micro"
  subnet_id                   = "${aws_subnet.PrivateSN.id}"
  associate_public_ip_address = false
  vpc_security_group_ids      = ["${aws_security_group.webSG.id}"]
  key_name                    = "cloudformkey"

  tags = {
    Name = "TF-DBserver"
  }
  //depends_on = ["aws_vpc.MainVPC.MainVPC-TF"]
}
