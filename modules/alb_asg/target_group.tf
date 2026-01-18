resource "aws_lb_target_group" "this" {
  name     = "${var.name}-tg"
  port     = 9090 # Changed from 80 to 9090
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}