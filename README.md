# Regional AWS-specific Resources

> This repository manages regional, AWS-specific resources for [@workloads](https://github.com/workloads).

## Table of Contents

<!-- TOC -->
* [Regional AWS-specific Resources](#regional-aws-specific-resources)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
    * [Development](#development)
  * [Usage](#usage)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
  * [Notes](#notes)
    * [Sensitive Data](#sensitive-data)
  * [Contributors](#contributors)
  * [License](#license)
<!-- TOC -->

## Requirements

- Amazon Web Services (AWS) [Account](https://aws.amazon.com/account/)
- HashiCorp Cloud Platform (HCP) [Account](https://portal.cloud.hashicorp.com/sign-in).
* HCP Terraform [Account](https://app.terraform.io/session)
- HashiCorp Terraform `1.9.x` or [newer](https://developer.hashicorp.com/terraform/downloads)

### Development

For development and testing of this repository:

- `terraform-docs` `0.18.0` or [newer](https://terraform-docs.io/user-guide/installation/)

## Usage

This repository uses a standard Terraform workflow (`init`, `plan`, `apply`).

For more information, including detailed usage guidelines, see the [Terraform documentation](https://developer.hashicorp.com/terraform/cli/commands).

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| aws_region | AWS Region. | `string` | yes |
| project_identifier | Human-readable Project Identifier. | `string` | yes |
| ssh_public_key | Public part of SSH Key Pair. | `string` | yes |
| tfe_organization | Name of HCP Terraform Organization. | `string` | yes |
| tfe_workspace | Name of HCP Terraform Workspace. | `string` | yes |
| iam_policy_description | Description of the IAM policy. | `string` | no |
| launch_template_instance_type_client | Type of Instance to launch for Nomad Server Launch Template. | `string` | no |
| launch_template_instance_type_server | Type of Instance to launch for Nomad Server Launch Template. | `string` | no |

### Outputs

| Name | Description |
|------|-------------|
| aws_autoscaling_group | Exported Attributes for `aws_autoscaling_group`. |
| aws_availability_zones | Exported Attributes for `aws_availability_zones.main` data source. |
| aws_availability_zones_az | Exported Attributes for `aws_availability_zones` (filtered by type `availability-zone`). |
| aws_iam_instance_profiles | Exported Attributes for `aws_iam_instance_profile`. |
| aws_iam_policies | Exported Attributes for `aws_iam_policy`. |
| aws_iam_role_policy_attachments | Exported Attributes for `aws_iam_role_policy_attachment`. |
| aws_iam_roles | Exported Attributes for `aws_iam_role`. |
| aws_key_pair | Exported Attributes for `aws_key_pair`. |
| aws_launch_template | Exported Attributes for `aws_launch_template`. |
| aws_placement_groups | Exported Attributes for `aws_placement_group`. |
| random_string_suffix | Exported Attributes for `random_string.suffix`. |
<!-- END_TF_DOCS -->

## Notes

### Sensitive Data

Terraform state may contain [sensitive data](https://developer.hashicorp.com/terraform/language/state/sensitive-data). This workspace uses [HCP Terraform](https://developer.hashicorp.com/terraform/cloud-docs) to safely store state, and encrypt the data at rest.

## Contributors

For a list of current (and past) contributors to this repository, see [GitHub](https://github.com/workloads/regional-aws-deployment/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may download a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

See the License for the specific language governing permissions and limitations under the License.
