output "public_conn" {
  value = "ssh ec2-user@${aws_instance.ec2.public_ip}"
}

output "private_conn" {
  value = "ssh ec2-user@${aws_instance.ec2.private_ip}"
}
