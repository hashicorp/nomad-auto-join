variable "namespace" {}

variable "instances" {
  description = "The number of nomad servers."
}

# AWS Specific variables
variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "The id of the ssh key to add to the servers"
}

variable "subnets" {
  description = "A list of subnets to attach the instances to"
  type        = "list"
}

variable "vpc_id" {
  description = "The id of the VPC which the servers are attached to"
}

variable "internal_alb_arn" {
  description = "The arn of the internal alb"
}

variable "external_alb_arn" {
  description = "The arn of the external alb"
}

variable "security_group" {
  description = "The id of the security group"
}

# Consul configuration
variable "consul_enabled" {
  description = "Should consul be installed onto the instance?"
}

variable "consul_type" {
  description = "Is the consul instance a server or client"
}

variable "consul_version" {
  description = "Version number for nomad"
}

variable "consul_join_tag_key" {
  description = "AWS Tag to use for consul auto-join"
}

variable "consul_join_tag_value" {
  description = "Value to search for in auto-join tag to use for consul auto-join"
}

# Nomad configuration
variable "nomad_enabled" {
  description = "Is nomad enabled on this instance"
}

variable "nomad_type" {
  description = "Is nomad a server or an agent"
}

variable "nomad_version" {
  description = "Version number for nomad"
}

variable "nomad_consul_uri" {
  description = "Location of consul server for bootstrapping"
  default     = "http://localhost:8500"
}

# HashiUI configuration
variable "hashiui_enabled" {
  description = "Is HashiUI enabled on this instance"
}

variable "hashiui_version" {
  description = "Version number for hashi-ui"
  default     = "0.3.6"
}
