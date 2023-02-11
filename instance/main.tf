provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "vm-instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  tags = var.tags
  key_name = var.key_pair
  security_groups = ["${aws_security_group.ssh_connection.name}"]
}

resource "aws_key_pair" "vm-instance-key" {
  key_name = "vm-instance-key-pair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCuAKSh76WT6NFjWFnSc0q/R+f6CmacsIbTD6kd38pdTUh1g2fPM0iz28dwR+EYOnNcdlnTnAyaaeLKcHurnfGuSAyLK7prFHNS4XO/f4VAhRdIHCeYamrE1vNABgcN1ipUrFI3S0j8zPYth+aH1dqST/cbb6k4foSvfa6pqoe/lWj8Oo8FjJEuQVjQ1FYvjuUf/44qJyhrvxskqpFtogG6jiQfUjp0UEZBGmeGjTp+kQBBpyE/q2V5WxXvX+gsFTbIjKqQaFXdciqHbqvOE+QrnnaUiNohrVblUWIGa+Atqe45t0eGRfBlt72ioJ6ks2+mTRmf7qLIa+FU6nn9xU2L73HT2QT3i6jLRDKyV3+XNQrK3un8bNwCaXl1GezUpiD5FmNZUc/EEzez24EK4uppOW5R7r/VfZFy59Kk3cT1WR64O0pgWo+7KImICoRMQOX+jWikg8WYuuR1NU16BuXTNprtTVOWjbVNcFSmzPIgKEInFVV/mk32xCNHmRDrO9s= arojaspu@arojaspu-2.local"
}

resource "aws_security_group_rule" "ssh_connection" {
  name = var.sg_name
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks 
    }
  }
  dynamic "egress" {
    for_each = var.egress_rules
    content {
        from_port = egress.value.from_port
        to_port = egress.value.to_port
        protocol = egress.value.protocol
        cidr_blocks = egress.value.cidr_blocks 
    }
  }
}