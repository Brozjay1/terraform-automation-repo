resource "aws_key_pair" "new_terra_key" {
    key_name = "new_terra_key"
    public_key = file("~/.ssh/new_terra_key.pub")
}

resource "aws_launch_template" "Ec2_intance_temp" {
    image_id = var.ami_id
    instance_type = var.instance_type
    key_name = aws_key_pair.new_terra_key.key_name

    user_data = base64encode(<<-EOF
                #!/bin/bash
                sudo apt-get update -y
                sudo apt install -y apache2 git
                sudo systemctl start apache2
                sudo systemctl enable apache2
                sudo rm -rf /var/www/html/*
                cd /var/www/html
                sudo git clone ${var.github} .
                sudo systemctl restart apache2
                EOF 
    )
    vpc_security_group_ids = [var.Ec2_sg_id]
}