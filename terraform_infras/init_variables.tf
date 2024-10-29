variable "github_repo" {
    description = "The url of the clone github repo"
    type = string
    default = "https://github.com/monyslim/dragon-mailer.git"
}

variable "github" {
    description = "The url of the clone github repo"
    type = string
    default = "https://github.com/monyslim/booksfinder-v1.git"
}

variable "ami_id" {
    description = "The ami id for the ec2 instances"
    type = string
    default = "ami-0e86e20dae9224db8"
}