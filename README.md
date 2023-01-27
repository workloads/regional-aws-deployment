<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| tfe_organization | Name of the Terraform Cloud Organization. | `string` | yes |

### Outputs

| Name | Description |
|------|-------------|
| aws_availability_zones_az | Exported Attributes for `aws_availability_zones` (filtered by type `availability-zone`). |
| instance_ami | Exported Attributes for `aws_ami.main` data source. |
| random_string_suffix | Exported Attributes for `random_string.suffix`. |
| zone_specific_suffix | Zone-specific Suffix for Resources. |
<!-- END_TF_DOCS -->