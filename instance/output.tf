output "instance_ip" {
    value = aws_instance.vm-instance.*.public_ip
}