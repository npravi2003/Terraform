#Variable for Terraform ec2 instance provisioning

variable "azone"{
 type = "list"
 default = ["us-east-2a","us-east-2b","us-east-2c"]
}

variable "numberofinstances" {
 default = "6"
}

variable "securitygroup"{
 default = "devops_sg"
}


