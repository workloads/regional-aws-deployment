# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "role" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "ec2.amazonaws.com"

        # region-specific endpoint, see https://docs.aws.amazon.com/general/latest/gr/ec2-service.html#ec2_region
        #"ec2.${var.aws_region}.amazonaws.com"

        # TODO: possibly add management region
        # "ec2.${var.management_region_aws}.amazonaws.com"
      ]
    }

    actions = [
      "sts:AssumeRole"

    ]
  }
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "main" {
  name               = local.default_name
  path               = var.iam_role_path
  assume_role_policy = data.aws_iam_policy_document.role.json
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile
resource "aws_iam_instance_profile" "main" {
  name_prefix = local.default_name
  role        = aws_iam_role.main.name
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "compute" {
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

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "main" {
  name        = local.default_name
  description = var.iam_policy_description
  policy      = data.aws_iam_policy_document.compute.json
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main.arn
}
