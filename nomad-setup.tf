resource "aws_key_pair" "nomad" {
  key_name   = "${var.namespace}-nomad"
  public_key = "${file("${var.public_key_path}")}"
}

module "servers" {
  source = "./nomad"

  namespace = "${var.namespace}-server"
  instances = "${var.nomad_servers}"

  subnets          = ["${aws_subnet.default.*.id}"]
  vpc_id           = "${aws_vpc.default.id}"
  internal_alb_arn = "${aws_alb.internal.arn}"
  external_alb_arn = "${aws_alb.external.arn}"
  security_group   = "${aws_security_group.default.id}"
  key_name         = "${aws_key_pair.nomad.id}"

  consul_enabled        = true
  consul_type           = "server"
  consul_version        = "${var.consul_version}"
  consul_join_tag_key   = "${var.consul_join_tag_key}"
  consul_join_tag_value = "${var.consul_join_tag_value}"

  nomad_enabled = true
  nomad_type    = "server"
  nomad_version = "${var.nomad_version}"

  hashiui_enabled = false
}

module "clients" {
  source = "./nomad"

  namespace = "${var.namespace}-client"
  instances = "${var.nomad_agents}"

  subnets          = ["${aws_subnet.default.*.id}"]
  vpc_id           = "${aws_vpc.default.id}"
  internal_alb_arn = "${aws_alb.internal.arn}"
  external_alb_arn = "${aws_alb.external.arn}"
  security_group   = "${aws_security_group.default.id}"
  key_name         = "${aws_key_pair.nomad.id}"

  consul_enabled        = true
  consul_type           = "client"
  consul_version        = "${var.consul_version}"
  consul_join_tag_key   = "${var.consul_join_tag_key}"
  consul_join_tag_value = "${var.consul_join_tag_value}"

  nomad_enabled = true
  nomad_type    = "client"
  nomad_version = "${var.nomad_version}"

  hashiui_enabled = true
  hashiui_version = "${var.hashiui_version}"
}
