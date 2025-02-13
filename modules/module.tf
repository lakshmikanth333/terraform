module "ec2_instnce" {
source = "./server_info"
  ami = "ami-085ad6ae776d8f09c"
  instance_type = "t2.micro"
  server_name = "prod"
  msg = "sg_1"
}

