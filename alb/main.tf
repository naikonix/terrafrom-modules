# Security Group for ALB
# Create security group for the Application Load Balancer
resource "aws_security_group" "create-sg" {
   name = "${var.alb_name}-load-balancer"
   description = "allow HTTPS to ${var.alb_name} Load Balancer (ALB)"
   vpc_id = "${var.vpc}"
   ingress {
       from_port = "80"
       to_port = "80"
       protocol = "tcp"
       cidr_blocks = "${var.source_cidr}"
   }
   ingress {
       from_port = "443"
       to_port = "443"
       protocol = "tcp"
       cidr_blocks = "${var.source_cidr}"
   }
   egress{
        from_port         = 0
        to_port           = 0
        protocol          = "-1"
        cidr_blocks       = ["0.0.0.0/0"]
   }
   tags = "${merge(var.common_tags,map("Name" ,"${var.alb_name}"))}"
}

resource "aws_alb" "create_alb" {
 name            = "${var.alb_name}"
 internal        = "${var.alb_internet_accessbility}"
 idle_timeout    = "300"
 load_balancer_type = "${var.alb_load_balancer_type}"
 security_groups = [
   "${aws_security_group.create-sg.id}"
 ]
 subnets = "${var.custom-subnets}"
 enable_deletion_protection = "${var.deletion_protection}"
 tags = "${merge(var.common_tags,map("Name" ,"${var.alb_name}"))}"
}

resource "aws_alb_listener" "create_listner_80" {
 load_balancer_arn = "${aws_alb.create_alb.arn}"
 port              = "80"
 protocol          = "HTTP"

 default_action {
   type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
 }
}

resource "aws_alb_listener" "create_listner_443" {
  count             = "${var.enable_https ? 1 : 0}"
  load_balancer_arn = "${aws_alb.create_alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "${var.ssl_policy}"
  certificate_arn   = "${var.certificate_arn}"

  default_action {
   type = "fixed-response"
    fixed_response {
      content_type = "application/json"
      message_body = "SORRY"
      status_code = "506"
    }
 }
}