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

variable "vpc_cidr_block" {
  description = "The top-level CIDR block for the VPC."
  default     = "10.1.0.0/16"
}

variable "cidr_blocks" {
  description = "The CIDR blocks to create the workstations in."
  default     = ["10.1.1.0/24", "10.1.2.0/24"]
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

variable "public_key_path" {
  description = "The absolute path on disk to the SSH public key."
  default     = "~/.ssh/id_rsa.pub"
}
