#Uploading Key Pair
resource "aws_key_pair" "aws-key" {
  key_name   = "aws-key"
  public_key = file(var.PUBLIC_KEY_PATH)
}


# Bastion Host
resource "aws_instance" "nginx_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"
  tags = {
    Name = "nginx_server"
  }
  subnet_id = aws_subnet.prod-subnet-public-1.id
  vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]
  key_name = aws_key_pair.aws-key.id

  provisioner "file" {
    source      = "nginx.sh"
    destination = "/tmp/nginx.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/nginx.sh",
      "sudo /tmp/nginx.sh"
    ]
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("${var.PRIVATE_KEY_PATH}")
  }
}


# Private EC2
resource "aws_instance" "nginx_private" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private-subnet-1.id
  vpc_security_group_ids = ["${aws_security_group.webserver-security-group.id}"]

  key_name                    = aws_key_pair.aws-key.id
  associate_public_ip_address = false
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name" = "EC2-Private"
  }
}