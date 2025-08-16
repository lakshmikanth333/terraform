provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "remote_demo" {
  ami           = "ami-0ec18f6103c5e0491"
  instance_type = "t2.large"
  key_name      = "my-key"

  tags = {
    Name = "RemoteProvisionerDemo"
  }

  # remote provisioner
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd -y",
      "sudo systemctl start httpd",
      "echo 'Hello from Remote Provisioner' | sudo tee /var/www/html/index.html"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/my-key.pem")
    host        = self.public_ip
  }
}

output "remote_demo_public_ip" {
  value = aws_instance.remote_demo.public_ip
}
