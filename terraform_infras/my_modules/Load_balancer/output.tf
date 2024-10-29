output "load_balancer_dns" {
    description = "The dns of the Load balancer"
    value = aws_lb.static_web_lb.dns_name
}

output "target_group_arn" {
    description = "The arn of the target group"
    value = aws_lb_target_group.static_tg.arn
}