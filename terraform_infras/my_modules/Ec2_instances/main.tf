resource "aws_key_pair" "new_terra_key" {
    key_name = "ec2_terra_key"
    public_key = file("~/.ssh/ec2_terra_key.pub")
}

resource "aws_instance" "static_web" {
    count = var.instance_count
    ami = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.new_terra_key.key_name
    subnet_id = element(var.public_subnet_ids, count.index)
    security_groups = [var.instance_sg_id]

    user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update -y
                sudo apt install -y apache2 git
                sudo systemctl start apache2
                sudo systemctl enable apapche2
                sudo rm -rf /var/www/html/*
                cd /var/www/html
                sudo git clone ${var.github_repo} .
                sudo systemctl restart apache2
                EOF 
    tags = {
      Name = "${var.instance_name}-${count.index + 1}"
    }

    associate_public_ip_address = true
}