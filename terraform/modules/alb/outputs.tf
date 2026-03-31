output "alb_sg_id" {
  value = data.aws_security_group.alb_sg.id
}

output "target_group_arn" {
  value = aws_lb_target_group.tg.arn
}

output "alb_dns_name" {
  value = data.aws_lb.alb.dns_name
}
