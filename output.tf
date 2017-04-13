output "external_alb_dns" {
  value = "${aws_alb.external.dns_name}"
}

output "external_alb_arn" {
  value = "${aws_alb.external.arn}"
}

output "internal_alb_dns" {
  value = "${aws_alb.internal.dns_name}"
}

output "internal_alb_arn" {
  value = "${aws_alb.internal.arn}"
}

output "ssh_host" {
  value = "${aws_instance.ssh_host.public_ip}"
}
