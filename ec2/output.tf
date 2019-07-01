output "public_ip" {
  value = "${aws_instance.ec2-instance.public_ip}"
}

output "private_ip" {
  value = "${aws_instance.ec2-instance.private_ip}"
}

output "instance_id" {
  value = "${aws_instance.ec2-instance.id}"
}

