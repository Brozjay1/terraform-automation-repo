variable "vpc_cidr" {
    type = string
}

variable "public_subnet_cidrs" {
    type = list(string)
}

variable "availability_zones" {
    description = "List of availability zones where the subnets will be"
    type = list(string)
}