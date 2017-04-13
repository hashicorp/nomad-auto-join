# Create the user-data
data "template_file" "config_consul" {
  template = "${file("${path.module}/templates/consul-${var.consul_type}.json.tpl")}"

  vars {
    instances             = "${var.instances}"
    consul_join_tag_key   = "${var.consul_join_tag_key}"
    consul_join_tag_value = "${var.consul_join_tag_value}"
  }
}

data "template_file" "config_nomad" {
  template = "${file("${path.module}/templates/nomad-${var.nomad_type}.hcl.tpl")}"

  vars {
    instances = "${var.instances}"
  }
}

data "template_file" "startup" {
  template = "${file("${path.module}/templates/startup.sh.tpl")}"

  vars {
    consul_enabled = "${var.consul_enabled}"
    consul_version = "${var.consul_version}"
    consul_type    = "${var.consul_type}"
    consul_config  = "${data.template_file.config_consul.rendered}"

    nomad_enabled = "${var.nomad_enabled}"
    nomad_version = "${var.nomad_version}"
    nomad_type    = "${var.nomad_type}"
    nomad_config  = "${data.template_file.config_nomad.rendered}"

    hashiui_enabled = "${var.hashiui_enabled}"
    hashiui_version = "${var.hashiui_version}"
  }
}

resource "aws_launch_configuration" "default" {
  name = "${var.namespace}"

  image_id      = "${data.aws_ami.ubuntu-1604.id}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"

  iam_instance_profile = "${aws_iam_instance_profile.consul-join.name}"
  security_groups      = ["${var.security_group}"]

  user_data = "${data.template_file.startup.rendered}"
}

resource "aws_autoscaling_group" "default" {
  name     = "${var.namespace}"
  max_size = 5
  min_size = "${var.instances}"

  launch_configuration = "${aws_launch_configuration.default.name}"
  vpc_zone_identifier  = ["${var.subnets}"]

  target_group_arns = ["${concat(
    aws_alb_target_group.nomad.*.arn,
    aws_alb_target_group.consul.*.arn,
    aws_alb_target_group.ui.*.arn,
    aws_alb_target_group.fabio.*.arn)}"]

  tag = {
    key                 = "Name"
    value               = "${var.namespace}"
    propagate_at_launch = true
  }

  tag = {
    key                 = "${var.consul_join_tag_key}"
    value               = "${var.consul_join_tag_value}"
    propagate_at_launch = true
  }
}
