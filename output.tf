output "alb_dns" {
  value = "${aws_alb.external.dns_name}"
}

output "alb_arn" {
  value = "${aws_alb.external.arn}"
}

output "ssh_host" {
  value = "${aws_instance.ssh_host.public_ip}"
}
