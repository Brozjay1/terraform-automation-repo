output "instance_ids" {
    description = "The ids of the ec2 instances"
    value = aws_instance.static_web[*].id
}

output "instance_public_ip" {
    description = "The public ip addresses of the ec2 instances"
    value = aws_instance.static_web[*].public_ip
}

output "instance_private_ip" {
    description = "The private ip addresses of the ec2 instances"
    value = aws_instance.static_web[*].private_ip
}