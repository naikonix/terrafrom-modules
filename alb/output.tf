output "alb_security_group" {
 description = "Security Group ID to your Auto Scaling group."
 value       = "${aws_security_group.create-sg.id}"
}

output "alb_arn" {
  description = "Application Load Balancer ARN"
  value = "${aws_alb.create_alb.arn}"
}

# output "listener-arn-443" {
#   description = "Listener ARN on Port 443"
#   value = "${var.enable_https ? aws_alb_listener.create_listner_443.arn : ""}"
#   # value = "${aws_alb_listener.create_listner_443.arn}"
#   # value = "${element(concat(aws_alb_listener.create_listner_443.arn, list(""), 0))}"
# }

output "listener-arn-80" {
  description = "Listener ARN on Port 80"
  value = "${aws_alb_listener.create_listner_80.arn}"
}


output "alb_dns" {
  description = "DNS Name"
  value = "${aws_alb.create_alb.dns_name}"
}

output "zone_id" {
  value = "${aws_alb.create_alb.zone_id}"
}
