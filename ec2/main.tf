resource "aws_instance" "ec2-instance" {
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  key_name               = "${var.key_name}"
  source_dest_check      = "${var.source_dest_check}"
  root_block_device {
    volume_type           = "gp2"
    volume_size           = "${var.volume_size}"
    delete_on_termination = true
  }
  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.instance_name}"
      )
  )}"
}
