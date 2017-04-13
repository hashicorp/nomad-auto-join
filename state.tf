terraform {
  backend "s3" {
    bucket  = "nic-terraform-state"
    key     = "examples/nomad/terraform.state"
    region  = "eu-west-1"
    profile = "hashicorp"
  }
}
