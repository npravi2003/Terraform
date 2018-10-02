#AWS instance provisioning using Terraform

provider "aws" {
  region = "us-east-2"

}

resource "aws_iam_role" "S3Fullaccess_role" {
  name = "S3Fullaccess-ec2-tf"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile"
  role = "${aws_iam_role.S3Fullaccess_role.name}"
}

resource "aws_iam_role_policy" "role_policy" {
  name = "role_policy"
  role = "${aws_iam_role.S3Fullaccess_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}



resource "aws_instance" "WebServer" {
  count                = "${var.numberofinstances}"
  ami                  = "ami-0cf31d971a3ca20d6"
  instance_type        = "t2.micro"
  availability_zone    = "${element(var.azone,count.index)}"
  key_name             = "lpldevops_key"
  iam_instance_profile = "${aws_iam_instance_profile.instance_profile.name}"

  security_groups = [
    "${var.securitygroup}",
  ]

  user_data = "${file("userdata${count.index + 1}.sh")}"

  tags {
    Name        = "WebServer${count.index +1}"
    Dept        = "DevOpsteam "
    Implementer = "Devopsmember"
  }
}

