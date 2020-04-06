resource "aws_vpc" "MainVPC" {
  cidr_block           = "10.100.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "MainVPC-TF"
  }
}

// Create Private and Public Subnets
resource "aws_subnet" "PublicSN" {
  vpc_id            = "${aws_vpc.MainVPC.id}"
  cidr_block        = "10.100.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "PublicEC2SN"
  }
}

resource "aws_subnet" "PrivateSN" {
  vpc_id            = "${aws_vpc.MainVPC.id}"
  cidr_block        = "10.100.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "PrivateEC2SN"
  }
}

resource "aws_internet_gateway" "MainIGW" {
  vpc_id = "${aws_vpc.MainVPC.id}"

  tags = {
    Name = "MainIGW"
  }
}


resource "aws_route_table" "PublicRT" {
  vpc_id = "${aws_vpc.MainVPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.MainIGW.id}"
  }
  tags = {
    Name = "PublicRT"
  }
  //depends_on = ["${aws_internet_gateway.MainIGW}"]
}

resource "aws_route_table" "PrivateRT" {
  vpc_id = "${aws_vpc.MainVPC.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.WebNGW.id}"
  }
  tags = {
    Name = "PrivateRT"
  }
 // depends_on = ["${aws_nat_gateway.WebNGW}"]
}

resource "aws_route_table_association" "public" {
  subnet_id      = "${aws_subnet.PublicSN.id}"
  route_table_id = "${aws_route_table.PublicRT.id}"
}

resource "aws_route_table_association" "private" {
  subnet_id      = "${aws_subnet.PrivateSN.id}"
  route_table_id = "${aws_route_table.PrivateRT.id}"
}
