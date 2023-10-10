# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_serial_console_access
resource "aws_ec2_serial_console_access" "example" {
  enabled = true
}

# TODO: rewrite to non-default VPC
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group
resource "aws_default_security_group" "default" {
  vpc_id = var.security_group_vpc_id

  # SSH
  ingress {
    description = "generic SSH"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    self      = true
  }

  # HTTP
  ingress {
    description = "generic HTTP"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    self      = true
  }

  # HTTPs
  ingress {
    description = "generic HTTPs"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    self      = true
  }

  # Nomad HTTP
  ingress {
    description = "Nomad HTTP"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 4646
    to_port   = 4646
    protocol  = "tcp"
    self      = true
  }

  # Nomad RPC
  ingress {
    description = "Nomad RPC"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 4647
    to_port   = 4647
    protocol  = "tcp"
  }

  # Nomad Serf
  ingress {
    description = "Nomad Serf"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 4648
    to_port   = 4648
    protocol  = "udp"
    self      = true
  }

  egress {
    description = "Unrestricted Egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}
