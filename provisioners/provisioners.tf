
resource "aws_instance" "myserver" {
  ami           = "ami-0ec18f6103c5e0491"
  instance_type = "t2.large"
  key_name      = "my-key"

  tags = {
    Name = "ProvisionerDemo"
  }

  # file provisioner
  provisioner "file" {
    source      = "app.conf"
    destination = "/tmp/app.conf"
  }

  # remote provisioner
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd -y",
      "sudo systemctl start httpd",
      "echo 'Hello from Terraform on RedHat' | sudo tee /var/www/html/index.html"
    ]
  }

  # local provisioner
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> servers.txt && date >> servers.txt"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/my-key.pem")
    host        = self.public_ip
  }
}

output "public_ip" {
  value = aws_instance.myserver.public_ip
}
