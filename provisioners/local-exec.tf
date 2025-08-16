provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "local_demo" {
  ami           = "ami-0ec18f6103c5e0491"
  instance_type = "t2.large"
  key_name      = "my-key"

  tags = {
    Name = "LocalProvisionerDemo"
  }

  # local provisioner
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> local_servers.txt && date >> local_servers.txt"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/my-key.pem")
    host        = self.public_ip
  }
}

output "local_demo_public_ip" {
  value = aws_instance.local_demo.public_ip
}
