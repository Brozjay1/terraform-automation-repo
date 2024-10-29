variable "lb_sg_id" {
    description = "The security gruop to associate with the instances"
    type = string
}

variable "public_subnet_id_az1" {
    description = "subnets id of AZ"
    type = string
    default = "subnet-022d85d5a6c4e3fa6"
}

variable "public_subnet_id_az2" {
    description = "Subnet id of AZ"
    type = string
    default = "subnet-0469ca622a0420df0"
}

variable "vpc_id" {
    description = "The vpc id"
    type = string
}