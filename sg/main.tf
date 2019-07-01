resource "aws_security_group" "main_security_group" {
  vpc_id = "${var.vpc_id}"
  tags = {
      Name = "${format("%s-%s", lower(var.environment), lower(var.servicetype))}"
      Environment = "${lower(var.environment)}"
      Servicetype = "${lower(var.servicetype)}"
    }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "sg_egress_rules" {
   count = "${length(keys(var.rules_egress))}"
   type = "egress"
   security_group_id = "${aws_security_group.main_security_group.id}"
   cidr_blocks = "${compact(split(",", "${element(values(var.rules_egress), count.index)}"))}"
   from_port = "${element(split(":", "${element(keys(var.rules_egress), count.index)}"), 1)}"
   protocol = "${element(split(":", "${element(keys(var.rules_egress), count.index)}"), 0)}"
   to_port = "${element(split(":", "${element(keys(var.rules_egress), count.index)}"), 2)}"
}

resource "aws_security_group_rule" "sg_ingress_sg_rules" {
   count = "${length(keys(var.rules_sg))}"
   type = "ingress"
   security_group_id = "${aws_security_group.main_security_group.id}"
   source_security_group_id  = "${element(values(var.rules_sg), count.index)}"
   from_port = "${element(split(":", "${element(keys(var.rules_sg), count.index)}"), 1)}"
   protocol = "${element(split(":", "${element(keys(var.rules_sg), count.index)}"), 0)}"
   to_port = "${element(split(":", "${element(keys(var.rules_sg), count.index)}"), 2)}"
}

resource "aws_security_group_rule" "sg_ingress_rules" {
   count = "${length(keys(var.rules_ingress))}"
   type = "ingress"
   security_group_id = "${aws_security_group.main_security_group.id}"
   cidr_blocks = "${compact(split(",", "${element(values(var.rules_ingress), count.index)}"))}"
   from_port = "${element(split(":", "${element(keys(var.rules_ingress), count.index)}"), 1)}"
   protocol = "${element(split(":", "${element(keys(var.rules_ingress), count.index)}"), 0)}"
   to_port = "${element(split(":", "${element(keys(var.rules_ingress), count.index)}"), 2)}"
}

resource "aws_security_group_rule" "sg_self_rules" {
   count = "${length(var.rules_self)}"
   type = "ingress"
   self = true
   security_group_id = "${aws_security_group.main_security_group.id}"
   from_port = "${element(split(":", "${element(var.rules_self, count.index)}"), 1)}"
   protocol = "${element(split(":", "${element(var.rules_self, count.index)}"), 0)}"
   to_port = "${element(split(":", "${element(var.rules_self, count.index)}"), 2)}"
}
