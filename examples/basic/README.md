# Example: `basic`

This is a _basic_ example of the `regional-aws-deployment` module.

> **Note**
> The example code shown in [./main.tf](./main.tf) is provided for illustration purposes only.

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| aws_region | AWS Region. | `string` | no |

### Outputs

| Name | Description |
|------|-------------|
| aws_autoscaling_group | Exported Attributes for `aws_autoscaling_group`. |
| aws_availability_zones | Exported Attributes for `aws_availability_zones.main` data source. |
| aws_availability_zones_az | Exported Attributes for `aws_availability_zones` (filtered by type `availability-zone`). |
| aws_iam_instance_profiles | Exported Attributes for `aws_iam_instance_profile`. |
| aws_iam_policies | Exported Attributes for `aws_iam_polic`. |
| aws_iam_role_policy_attachments | Exported Attributes for `aws_iam_role_policy_attachment`. |
| aws_iam_roles | Exported Attributes for `aws_iam_role`. |
| aws_launch_template | Exported Attributes for `aws_launch_template`. |
| aws_placement_group | Exported Attributes for `aws_placement_group`. |
| random_string_suffix | Exported Attributes for `random_string.suffix`. |
<!-- END_TF_DOCS -->
