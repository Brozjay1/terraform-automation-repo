variable "ami" {
    description = "The ami id of the instance"
    type = string
}

variable "instance_type" {
    description = "The type of instance to launch"
    type = string
}

variable "public_subnet_ids" {
    description = "The subnets id where instance will be launched"
    type = list(string)
}

variable "instance_sg_id" {
    description = "The security group to attach to the instance"
    type = string
}

variable "github_repo" {
    description = "The url of the github repo to clone for the static web app"
    type = string
}

variable "instance_name" {
    description = "The name for the instances"
    type = string
}

variable "instance_count" {
    description = "The  number of ec2 instances to create"
    type = number
    default = 2
}