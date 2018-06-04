output "instances" {
  value = "${join(",", aws_instance.web-performance-test.*.public_dns)}"
}
