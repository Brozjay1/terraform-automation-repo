terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.65.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_key_pair" "new_terra_key" {
    key_name = "new_terra_key"
    public_key = file("~/.ssh/new_terra_key.pub")
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
module "VPC" {
  source = "/home/hp/static_web_auto_scaling/terraform_infras/my_modules/VPC"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones = ["us-east-1b", "us-east-1c"]
}

module "Security_group" {
  source = "/home/hp/static_web_auto_scaling/terraform_infras/my_modules/Security_group"
  vpc_id = module.VPC.vpc_id
}

module "Ec2_instances" {
  source = "/home/hp/static_web_auto_scaling/terraform_infras/my_modules/Ec2_instances"
  instance_name = "static_ec2"
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  instance_sg_id = module.Security_group.Ec2_sg_id
  github_repo = var.github_repo
  public_subnet_ids = module.VPC.public_subnet_ids
}

module "Launch_template" {
  source = "/home/hp/static_web_auto_scaling/terraform_infras/my_modules/Launch_template"
  ami_id = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  Ec2_sg_id = module.Security_group.Ec2_sg_id
  github = var.github
}

module "Load_balancer" {
  source = "/home/hp/static_web_auto_scaling/terraform_infras/my_modules/Load_balancer"
  vpc_id = module.VPC.vpc_id
  public_subnet_id_az1 = module.VPC.public_subnet_id_az1
  public_subnet_id_az2 = module.VPC.public_subnet_id_az2 
  lb_sg_id = module.Security_group.Lb_sg_id
}

module "Auto_scaling" {
  source = "/home/hp/static_web_auto_scaling/terraform_infras/my_modules/Auto_scaling"
  launch_template_id = module.Launch_template.launch_template_id
  key_name = aws_key_pair.new_terra_key.key_name
  target_group_arn = module.Load_balancer.target_group_arn
  public_subnet_ids = module.VPC.public_subnet_ids
  min_size = 2
  max_size = 5
  desired_capacity = 2
}