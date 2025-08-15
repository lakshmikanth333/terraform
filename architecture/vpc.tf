# VPC creation
resource "aws_vpc" "project_vpc" {
  cidr_block           = "10.0.0.0/20"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "project-main-vpc"
    Env  = "dev"
  }
}

# Subnet in us-east-1a
resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.project_vpc.id
  cidr_block              = "10.0.0.0/27"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "project-subnet-a"
  }
}

# Output for quick verification
output "vpc_cidr" {
  value = aws_vpc.project_vpc.cidr_block
}

output "subnet_info" {
  value = {
    az   = aws_subnet.subnet_a.availability_zone
    cidr = aws_subnet.subnet_a.cidr_block
  }
}

# Create security group to allow HTTP/HTTPS + SSH
resource "aws_security_group" "web_sg" {
  name        = "project-web-sg"
  description = "Allow web and SSH"
  vpc_id      = aws_vpc.project_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH limited to office IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["203.0.113.15/32"] # replace with your office/public IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

# Multiple instances using for_each
variable "machines" {
  default = {
    web = "t2.micro"
    app = "t2.medium"
    db  = "t2.large"
  }
}

resource "aws_instance" "app_servers" {
  for_each      = var.machines
  ami           = "ami-08c40ec9ead489470" # Amazon Linux 2 AMI in us-east-1
  instance_type = each.value
  subnet_id     = aws_subnet.subnet_a.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "${each.key}-server"
  }
}

# Same idea but with count (demo purpose)
variable "server_types" {
  default = ["t2.micro", "t3.medium", "t3.large"]
}

resource "aws_instance" "misc_servers" {
  count         = length(var.server_types)
  ami           = "ami-08c40ec9ead489470"
  instance_type = var.server_types[count.index]
  subnet_id     = aws_subnet.subnet_a.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "misc-${count.index}"
  }
}
