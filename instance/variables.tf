variable "ami_id" {
  default = ""
  description = "AMI ID"
  type = string
}

variable "instance_type" {
  description = "INSTANCE TYPE"
  type = string
}

variable "tags" {
  description = "TAGS OF EC2"
  type = map
}

variable "key_pair" {
  description = "SSH Key Pair Use To Connect"
  type = string
}

# Define variables for aws security group
variable "sg_name" {
    description = "SG NAME"
    type = string
}

variable "ingress_rules" {
    type = list
}

variable "egress_rules" {
    type = list
}

