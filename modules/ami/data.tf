data "aws_ami" "aws_ec2_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20*-x86_64-gp2"]
  }

  filter {
    name   = "is-public"
    values = [true]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "hypervisor"
    values = ["xen"]
  }

  owners = ["137112412989"]
}
