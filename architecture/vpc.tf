# -------------------------
# Create a VPC
# -------------------------
resource "aws_vpc" "vpc_1" {
  cidr_block = "10.0.0.0/20"
  tags = {
    Name = "my_vpc"
  }
}

# -------------------------
# Create a Subnet
# -------------------------
resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.vpc_1.id
  cidr_block        = "10.0.0.0/27"
  availability_zone = "us-east-1a"
  tags = {
    Name = "my_subnet"
  }
}

# -------------------------
# Outputs
# -------------------------
output "vpc_info" {
  value = aws_vpc.vpc_1.cidr_block
}

output "subnet_info" {
  value = {
    zone = aws_subnet.subnet_1.availability_zone
    cidr = aws_subnet.subnet_1.cidr_block
    name = aws_subnet.subnet_1.tags["Name"]
  }
}

# -------------------------
# Creating EC2 instances with for_each
# -------------------------
variable "machines" {
  type = map(string)
  default = {
    web = "t2.micro"
    app = "t2.medium"
    db  = "t2.large"
  }
}

resource "aws_instance" "ec2_servers" {
  for_each      = var.machines
  ami           = "ami-0abcd1234efgh5678"  # <-- Replace with a real AMI in your region
  instance_type = each.value
  subnet_id     = aws_subnet.subnet_1.id

  tags = {
    Name = each.key
  }
}

# -------------------------
# Creating EC2 instances with count
# -------------------------
variable "servers" {
  type    = list(string)
  default = ["t2.micro", "t3.medium", "t4.large"]
}

resource "aws_instance" "ec2" {
  count         = length(var.servers)
  ami           = "ami-0abcd1234efgh5678"  # <-- Replace with a real AMI in your region
  instance_type = var.servers[count.index]
  subnet_id     = aws_subnet.subnet_1.id

  tags = {
    Name = "${count.index}-server"
  }
}
