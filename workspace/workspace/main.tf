resource "aws_vpc" "ws_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc_${terraform.workspace}"
  }

}

resource "aws_subnet" "ws_sub" {
  vpc_id                  = aws_vpc.ws_vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "sub_${terraform.workspace}"
  }
}

resource "aws_security_group" "ws_sg" {
  name   = "sg_${terraform.workspace}"
  vpc_id = aws_vpc.ws_vpc.id

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "workspace_server" {
  ami                    = "ami-085ad6ae776d8f09c"
  subnet_id              = aws_subnet.ws_sub.id
  vpc_security_group_ids = [aws_security_group.ws_sg.id]
  instance_type          = lookup(var.server, terraform.workspace, "t2.micro")
  tags = {
    Name = "${terraform.workspace}.server"
  }

}

output "vpc_info" {
    value = {
        
    cidr_value = aws_vpc.ws_vpc.cidr_block
    route_table = aws_vpc.ws_vpc.main_route_table_id
    tags = aws_vpc.ws_vpc.tags

}
}

