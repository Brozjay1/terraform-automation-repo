variable "launch_template_id" {
    description = "The instance template for the auto scaling"
    type = string
}

variable "target_group_arn" {
    description = "The target group for the Load balancer"
    type = string
}

variable "key_name" {
    description = "The name of the key pair"
    type = string
}

variable "desired_capacity" {
    description = "Desired number of instances in the auto scaling group"
    type = number
}

variable "max_size" {
    description = "Minimum number of instance in the auto scaling group"
    type = number
}

variable "min_size" {
    description = "Maximum number of instances in the auto scaling group"
    type = number
}

variable "public_subnet_ids" {
    description = "Lists of the subnets ids"
    type = list(string)
}