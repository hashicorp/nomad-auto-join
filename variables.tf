variable "aws_region" {
  description = "AWS region to create the environment"
}

variable "aws_access_key_id" {
  description = "AWS access key"
}

variable "aws_secret_access_key" {
  description = "AWS secret"
}

variable "aws_zones" {
  description = "List of AWS availability zones"
  type        = "list"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "namespace" {
  description = <<EOH
The namespace to create the virtual training lab. This should describe the
training and must be unique to all current trainings. IAM users, workstations,
and resources will be scoped under this namespace.

It is best if you add this to your .tfvars file so you do not need to type
it manually with each run
EOH
}

variable "consul_version" {
  description = "Consul version to install"
}

variable "nomad_version" {
  description = "Nomad version to install"
}

variable "hashiui_version" {
  description = "Hashi-ui version to install"
}

variable "consul_join_tag_key" {
  description = "AWS Tag to use for consul auto-join"
}

variable "consul_join_tag_value" {
  description = "Value to search for in auto-join tag to use for consul auto-join"
}

variable "nomad_servers" {
  description = "The number of nomad servers."
}

variable "nomad_agents" {
  description = "The number of nomad agents"
}
