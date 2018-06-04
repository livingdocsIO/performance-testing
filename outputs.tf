output "instances" {
  value = "${join("\n", aws_instance.web-performance-test.*.public_dns)}"
}
