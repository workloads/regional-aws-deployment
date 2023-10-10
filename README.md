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
| launch_template_key_name | Name of (Public) Key for Instances in Launch Template. | `string` | yes |
| launch_template_user_data | User Data for Instances in Launch Template. | `string` | yes |
| launch_template_vpc_security_group_ids | List of Security Group IDs for Instances in Launch Template. | `list(string)` | yes |
| security_group_vpc_id | VPC ID of Security Group. | `string` | yes |
| tfe_organization | Name of Terraform Cloud Organization. | `string` | yes |
| autoscaling_group_desired_capacity | Desired Number of Instances in the Auto Scaling Group. | `number` | no |
| autoscaling_group_force_delete | Toggle to enable Force Deletion of Instances in the Auto Scaling Group. | `bool` | no |
| autoscaling_group_health_check_grace_period | Grace Period for Health Check of the Auto Scaling Group. | `number` | no |
| autoscaling_group_health_check_type | Type of Health Check of the Auto Scaling Group. | `string` | no |
| autoscaling_group_launch_template_version | Version of Launch Template to use for Autoscaling Group. | `string` | no |
| autoscaling_group_max_size | Maximum Number of Instances in the Auto Scaling Group. | `number` | no |
| autoscaling_group_min_size | Minimum Number of Instances in the Auto Scaling Group. | `number` | no |
| default_name_prefix | Default Name Prefix for Module-specific Resources. | `string` | no |
| iam_policy_description | Description of the IAM policy. | `string` | no |
| iam_role_path | Path for IAM Role. | `string` | no |
| launch_template_block_device_mappings | Block Device Configuration for Instances in Launch Template. | <pre>object({<br>    device_name     = string<br>    ebs_volume_size = number<br>  })</pre> | no |
| launch_template_disable_api_stop | Toggle to enable EC2 Instance Stop Protection. | `bool` | no |
| launch_template_disable_api_termination | Toggle to enable EC2 Instance Termination Protection. | `bool` | no |
| launch_template_ebs_optimized | Toggle to enable starting Instances with optimized EBS.. | `bool` | no |
| launch_template_instance_initiated_shutdown_behavior | Shutdown Behavior for Instances in Launch Template. | `string` | no |
| launch_template_instance_type | Type of EC2 Instance in Launch Template. | `string` | no |
| launch_template_metadata_options | Metadata Options for Instances in Launch Template. | <pre>object({<br>    http_endpoint               = string<br>    http_protocol_ipv6          = string<br>    http_put_response_hop_limit = number<br>    http_tokens                 = string<br>    instance_metadata_tags      = string<br>  })</pre> | no |
| launch_template_monitoring | Monitoring for Instances in Launch Template. | <pre>object({<br>    enabled = bool<br>  })</pre> | no |
| launch_template_network_interfaces | Network Interfaces for Instances in Launch Template. | <pre>object({<br>    associate_public_ip_address = bool<br>    delete_on_termination       = bool<br>    description_prefix          = string<br>  })</pre> | no |
| launch_template_tags_instance | Tags for Instances in Launch Template. | `map(string)` | no |
| launch_template_tags_network_interface | Tags for Network interface in Launch Template. | `map(string)` | no |
| launch_template_tags_volume | Tags for Volumes in Launch Template. | `map(string)` | no |
| launch_template_update_default_version | Toggle to update the Default Version of the Launch Template. | `bool` | no |
| placement_group_spread_level | Spread Level of Placement Groups. | `string` | no |

### Outputs

| Name | Description |
|------|-------------|
| aws_ami | Exported Attributes for `aws_ami.main` data source. |
| aws_autoscaling_group | Exported Attributes for `aws_autoscaling_group`. |
| aws_availability_zones | Exported Attributes for `aws_availability_zones.main` data source. |
| aws_availability_zones_az | Exported Attributes for `aws_availability_zones` (filtered by type `availability-zone`). |
| aws_iam_instance_profile | Exported Attributes for `aws_iam_instance_profile`. |
| aws_iam_policy | Exported Attributes for `aws_iam_policy`. |
| aws_iam_role | Exported Attributes for `aws_iam_role`. |
| aws_iam_role_policy_attachment | Exported Attributes for `aws_iam_role_policy_attachment`. |
| aws_launch_template | Exported Attributes for `aws_launch_template`. |
| aws_placement_group | Exported Attributes for `aws_placement_group`. |
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
