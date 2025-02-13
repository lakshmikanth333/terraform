resource "aws_vpc" "ws_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc_2"
  }

}

resource "aws_subnet" "ws_sub" {
  vpc_id                  = aws_vpc.ws_vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = var.sub
  }
}

resource "aws_security_group" "ws_sg" {
  name   = var.msg
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
  ami                    = var.ami_id
  vpc_security_group_ids = [aws_security_group.ws_sg.id]
  instance_type          = var.instance_type
  tags = {
    Name = "var.server_name"
  }
}


