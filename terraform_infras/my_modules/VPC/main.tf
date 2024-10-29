resource "aws_vpc" "static_vpc" {
    cidr_block = var.vpc_cidr
}

resource "aws_internet_gateway" "static_igw" {
    vpc_id = aws_vpc.static_vpc.id

    tags = {
      Name = "static_igw"
    }
}

resource "aws_subnet" "public_subnet" {
    count = length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.static_vpc.id
    cidr_block = var.public_subnet_cidrs[count.index]
    map_public_ip_on_launch = true
    availability_zone = var.availability_zones[count.index]

    tags = {
      Name = "Public_Subnet_${count.index + 1}"
    }
}

resource "aws_route_table" "public_RT" {
    vpc_id = aws_vpc.static_vpc.id

    tags = {
      Name = "public_RT"
    }
}

resource "aws_route" "public_route" {
    route_table_id = aws_route_table.public_RT.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.static_igw.id
}

resource "aws_route_table_association" "public_subnet_asst" {
    count = length(var.public_subnet_cidrs)
    subnet_id = aws_subnet.public_subnet[count.index].id
    route_table_id = aws_route_table.public_RT.id
}