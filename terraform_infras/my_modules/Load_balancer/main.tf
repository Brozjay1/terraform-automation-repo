resource "aws_lb" "static_web_lb" {
    internal = false
    load_balancer_type = "application"
    security_groups = [var.lb_sg_id]
    subnets = [
        var.public_subnet_id_az1,
        var.public_subnet_id_az2
    ]

    enable_deletion_protection = false
}

#target group for the load balancer
resource "aws_lb_target_group" "static_tg" {
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    health_check {
        path = "/index.html"
    }
}

#Listener for the Load balancer
resource "aws_lb_listener" "static_listener" {
    load_balancer_arn = aws_lb.static_web_lb.arn
    port = "80"
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.static_tg.arn
    }
}