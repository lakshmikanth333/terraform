provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "file_demo" {
  ami           = "ami-0ec18f6103c5e0491"
  instance_type = "t2.large"
  key_name      = "my-key"

  tags = {
    Name = "FileProvisionerDemo"
  }

  # file provisioner
  provisioner "file" {
    source      = "app.conf"
    destination = "/tmp/app.conf"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/my-key.pem")
    host        = self.public_ip
  }
}

output "file_demo_public_ip" {
  value = aws_instance.file_demo.public_ip
}
