# Regional Terraform Cloud Workspace for AWS-specific Resources

> This directory manages the lifecycle of (other) Terraform Cloud Workspace configurations for [@workloads](https://github.com/workloads).

## Table of Contents

<!-- TOC -->
* [Regional Terraform Cloud Workspace for AWS-specific Resources](#regional-terraform-cloud-workspace-for-aws-specific-resources)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

* HashiCorp Cloud Platform (HCP) [Account](https://portal.cloud.hashicorp.com/sign-in).
* Amazon Web Services (AWS) [Account](https://aws.amazon.com/account/)
* Terraform Cloud [Account](https://app.terraform.io/session)
* Terraform `1.3.0` or [newer](https://developer.hashicorp.com/terraform/downloads).

<!-- BEGIN_TF_DOCS -->
### Inputs

No inputs.

### Outputs

| Name | Description |
|------|-------------|
| aws_availability_zones_az | Exported Attributes for `aws_availability_zones` (filtered by type `availability-zone`). |
| instance_ami | Exported Attributes for `aws_ami.main` data source. |
| random_string_suffix | Exported Attributes for `random_string.suffix`. |
| zone_specific_suffix | Zone-specific Suffix for Resources. |
<!-- END_TF_DOCS -->## Author Information

This module is maintained by the contributors listed on [GitHub](https://github.com/workloads/regional-aws-deployment/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
