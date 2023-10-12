# TODO: replace with HCP Packer-managed resource
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
data "aws_ami" "main" {
  include_deprecated = false
  most_recent        = true

  owners = [
    "amazon"
  ]

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    ]
  }

  filter {
    name = "virtualization-type"

    values = [
      "hvm"
    ]
  }
}

# TODO: remap to Nomad-specific Security Groups
# retrieve information about the Default Security Group for the Default VPC
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones
data "aws_availability_zones" "main" {
  # only return available AZs (omitting impaired and unavailable ones)
  state = "available"

  # filter by Zone Type for AZs (and therefore exclude special AZs such as Wavelength)
  # CLI Command: `aws --region="${AWS_REGION}" ec2 describe-availability-zones --filter="Name=zone-type,Values=['availability-zone']"`
  # see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones#filter
  filter {
    name = "zone-type"

    values = [
      "availability-zone"
    ]
  }
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "iam_policy_client" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeTags",
      "autoscaling:DescribeAutoScalingGroups",
    ]

    resources = [
      "*",
    ]
  }
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "iam_policy_server" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeTags",
      "autoscaling:DescribeAutoScalingGroups",
    ]

    resources = [
      "*",
    ]
  }
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "iam_role" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "ec2.amazonaws.com"
      ]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

# TODO: remap to Nomad-specific Security Groups
# retrieve information about the Default VPC for the selected `aws_region`
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
data "aws_vpc" "default" {
  default = true
  state   = "available"
}
