output "vpc_id" {
    value = aws_vpc.static_vpc.id
}

output "public_subnet_id_az1" {
    description = "The id of the subnet in AZ1"
    value = aws_subnet.public_subnet[0].id
}

output "public_subnet_id_az2" {
    description = "The id of the subnet in AZ1"
    value = aws_subnet.public_subnet[1].id
}

output "public_subnet_ids" {
    value = aws_subnet.public_subnet[*].id
}