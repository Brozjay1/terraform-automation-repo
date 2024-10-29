output "load_balancer_dns" {
    value = module.Load_balancer.load_balancer_dns
}

output "instance_public_ip" {
    value = module.Ec2_instances.instance_public_ip
}