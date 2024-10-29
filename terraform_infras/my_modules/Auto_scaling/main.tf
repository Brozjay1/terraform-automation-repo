resource "aws_autoscaling_group" "static_asg" {
    desired_capacity = var.desired_capacity
    max_size = var.max_size
    min_size = var.min_size
    launch_template {
        id = var.launch_template_id
        version = "$Latest"
    }

    vpc_zone_identifier = var.public_subnet_ids

    target_group_arns = [var.target_group_arn]

    tag {
        key = "Name"
        value = "Ec2_intance_temp"
        propagate_at_launch = true
    }    
}

# create policy for dynamic scaling
resource "aws_autoscaling_policy" "scale_up_policy" {
    name = "scale_up_policy"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 200
    autoscaling_group_name = aws_autoscaling_group.static_asg.name
}

resource "aws_autoscaling_policy" "scale_down_policy" {
    name = "scale_down_policy"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 200
    autoscaling_group_name = aws_autoscaling_group.static_asg.name
}