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

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "iam_policy_client" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeInstancesInput,"
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
      # TODO: make this more strict
      "ec2:*"
    ]

    resources = [
      # TODO: make this more strict
      "arn:aws:ec2:${var.aws_region}:*:instance/*",
    ]
  }
}
