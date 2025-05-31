resource "aws_instance" "instance1" {
#  ami                    = var.AMIS[var.REGION]
  ami			= "ami-084568db4383264d4"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_1.id
  key_name               = var.PUB_KEY
  vpc_security_group_ids = [aws_security_group.terrafrom_sg.id]
  associate_public_ip_address = true
 
#  depends_on = [
 #   aws_security_group.allow_ssh_http_https,
 #   aws_internet_gateway.igw
#  ]

  user_data       = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nginx

              # Create index.html with H1 tag in the default NGINX web directory
              echo "<h1>Hello From Ubuntu EC2 Instance!!!</h1>" | sudo tee /var/www/html/index.html

              # Update NGINX to listen on port 8080
              sudo sed -i 's/listen 80 default_server;/listen 8080 default_server;/g' /etc/nginx/sites-available/default

              # Restart NGINX to apply the changes
              sudo systemctl restart nginx
              EOF 

  tags = {
    Name = "Server-1"
  }
}

output "PublicIP-Server1" {
  value = aws_instance.instance1.public_ip
}

resource "aws_instance" "instance2" {
#  ami                    = var.AMIS[var.REGION]
  ami			= "ami-084568db4383264d4"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_2.id
  key_name               = var.PUB_KEY
  vpc_security_group_ids = [aws_security_group.terrafrom_sg.id]
  associate_public_ip_address = true
 
#  depends_on = [
#    aws_security_group.allow_ssh_http_https,
#    aws_internet_gateway.igw
#  ]
  user_data       = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nginx

              # Create index.html with H1 tag in the default NGINX web directory
              echo "<h1>Hello From Ubuntu EC2 Instance!!!</h1>" | sudo tee /var/www/html/index.html

              # Update NGINX to listen on port 8080
              sudo sed -i 's/listen 80 default_server;/listen 8080 default_server;/g' /etc/nginx/sites-available/default

              # Restart NGINX to apply the changes
              sudo systemctl restart nginx
              EOF 

  tags = {
    Name = "Server-2"
  }
}

output "PublicIP-Server2" {
  value = aws_instance.instance2.public_ip
}
