# TODO: rewrite to non-default VPC and move to `scaled-compute` module
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group
resource "aws_default_security_group" "default" {
  vpc_id = data.aws_vpc.default.id

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
    description = "Nomad RPC (TCP)"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 4647
    to_port   = 4647
    protocol  = "tcp"
    self      = true
  }

  ingress {
    description = "Nomad RPC (UDP)"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 4647
    to_port   = 4647
    protocol  = "udp"
    self      = true
  }

  # Nomad Serf
  ingress {
    description = "Nomad Serf (TCP)"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 4648
    to_port   = 4648
    protocol  = "tcp"
    self      = true
  }

  ingress {
    description = "Nomad Serf (UDP)"

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

    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    self = true
  }
}


#locals {
#  # `regional_name_client` and `regional_name_server` are processed
#  # with the `replace` function and will have `%s` replaced by the AZ
#  regional_name_client = "client-%s-${var.random_suffix}"
#  regional_name_server = "server-%s-${var.random_suffix}"
#}

#variable "tfe_organization" {
#  type        = string
#  description = "Name of Terraform Cloud Organization."
#}

#${random_string.suffix.result}

locals {
  # assemble Policy Description from user-supplied argument, and TFC-supplied AWS Region
  iam_policy_description = "${var.iam_policy_description} (for `${var.aws_region}`)."
}

