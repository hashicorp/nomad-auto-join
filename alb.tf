# Create a new load balancer
resource "aws_alb" "external" {
  name            = "${var.namespace}-external"
  internal        = false
  security_groups = ["${aws_security_group.default.id}"]
  subnets         = ["${aws_subnet.default.*.id}"]
}

resource "aws_alb" "internal" {
  name            = "${var.namespace}-internal"
  internal        = true
  security_groups = ["${aws_security_group.default.id}"]
  subnets         = ["${aws_subnet.default.*.id}"]
}
