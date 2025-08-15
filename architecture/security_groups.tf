resource "aws_security_group" "sg_for_web" {
  name = "sg-1"
  vpc_id = aws_vpc.vpc_1.id
  
  # inbound rules
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/20"]
  }

  # out bound rules
  egress {
    from_port = 443
    to_port = 442
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-sg"
  }

}

# using dynamic block to create security groups

variable "ports" {
  default = ["22", "80", "443"]
}

resource "aws_security_group" "dynamic_sg" {
    vpc_id = aws_vpc.vpc_1.id
    name = "dynamic_sg"
    dynamic "ingress" {
      for_each = var.ports
      content {
        from_port = ingress.value
        to_port = ingress.value
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

      }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

