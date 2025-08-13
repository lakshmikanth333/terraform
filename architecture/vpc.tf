resource "aws_vpc" "vpc_1" {
  cidr_block = "10.0.0.0/20"
  tags = {
    Name = "my_vpc"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.vpc_1.id
  cidr_block        = "10.0.0.0/27"
  availability_zone = "us-east-1a"
  tags = {
    Name = "my_subnet"
  }
}
output "vpc_info" {
  value = aws_vpc.vpc_1.cidr_block
}
output "subnet_info" {
  value = {
    zone = aws_subnet.subnet_1.availability_zone
    cidr = aws_subnet.subnet_1.cidr_block
    name = aws_subnet.subnet_1.tags
  }
}