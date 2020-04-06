resource "aws_nat_gateway" "WebNGW" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.PublicSN.id}"

  tags = {
    Name = "WebNGW"
  }
}
