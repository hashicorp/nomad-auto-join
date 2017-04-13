module "vpc" {
  source = "/Users/nicj/Developer/terraform/terraform-modules/vpc"

  aws_region            = "${var.aws_region}"
  aws_access_key_id     = "${var.aws_access_key_id}"
  aws_secret_access_key = "${var.aws_secret_access_key}"
  namespace             = "${var.namespace}"
}

module "servers" {
  source = "/Users/nicj/Developer/terraform/terraform-modules/hashicorp-suite"

  namespace = "${var.namespace}-server"

  instances = "${var.nomad_servers}"

  aws_region            = "${var.aws_region}"
  aws_access_key_id     = "${var.aws_access_key_id}"
  aws_secret_access_key = "${var.aws_secret_access_key}"
  aws_zones             = "${var.aws_zones}"
  subnets               = ["${module.vpc.subnets}"]
  vpc_id                = "${module.vpc.id}"

  consul_enabled        = true
  consul_type           = "server"
  consul_version        = "${var.consul_version}"
  consul_join_tag_key   = "${var.consul_join_tag_key}"
  consul_join_tag_value = "${var.consul_join_tag_value}"

  nomad_enabled = true
  nomad_type    = "server"
  nomad_version = "${var.nomad_version}"

  hashiui_enabled = true
  hashiui_version = "${var.hashiui_version}"
}

module "clients" {
  source = "/Users/nicj/Developer/terraform/terraform-modules/hashicorp-suite"

  namespace = "${var.namespace}-client"

  instances = "${var.nomad_agents}"

  aws_region            = "${var.aws_region}"
  aws_access_key_id     = "${var.aws_access_key_id}"
  aws_secret_access_key = "${var.aws_secret_access_key}"
  aws_zones             = "${var.aws_zones}"
  subnets               = ["${module.vpc.subnets}"]
  vpc_id                = "${module.vpc.id}"

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
