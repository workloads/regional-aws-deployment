# Regional AWS-specific Resources

> This directory manages the lifecycle of regional, AWS-specific resources for [@workloads](https://github.com/workloads).

## Table of Contents

<!-- TOC -->
* [Regional AWS-specific Resources](#regional-aws-specific-resources)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
  * [Notes](#notes)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

* HashiCorp Cloud Platform (HCP) [Account](https://portal.cloud.hashicorp.com/sign-in).
* Amazon Web Services (AWS) [Account](https://aws.amazon.com/account/)
* Terraform Cloud [Account](https://app.terraform.io/session)
* Terraform `1.5.0` or [newer](https://developer.hashicorp.com/terraform/downloads).

## Usage

This repository uses a standard Terraform workflow (`init`, `plan`, `apply`).

For more information, including detailed usage guidelines, see the [Terraform documentation](https://developer.hashicorp.com/terraform/cli/commands).

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| aws_region | AWS Region. | `string` | yes |
| tfe_organization | Name of Terraform Cloud Organization. | `string` | yes |
| iam_policy_description | Description of the IAM policy. | `string` | no |
| launch_template_instance_type | Type of EC2 Instance in Launch Template. | `string` | no |

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
| aws_launch_template | Exported Attributes for `aws_launch_template`. |
| aws_placement_groups | Exported Attributes for `aws_placement_group`. |
| random_string_suffix | Exported Attributes for `random_string.suffix`. |
<!-- END_TF_DOCS -->

## Notes

* Terraform state may contain [sensitive data](https://developer.hashicorp.com/terraform/language/state/sensitive-data). This workspace uses [Terraform Cloud](https://developer.hashicorp.com/terraform/cloud-docs) to safely store state, and encrypt the data at rest.

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/regional-aws-deployment/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
