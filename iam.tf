module "instance_profiles" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    for type, profile in local.deployments : type => profile
  }

  source  = "ksatirli/instance-profile/aws"
  version = "0.9.0"

  iam_policy_document      = each.value.iam_policy_document
  iam_policy_description   = each.value.iam_policy_description
  iam_role_policy_document = each.value.iam_role_policy_document
  iam_role_name            = each.value.iam_name

  instance_profile_name = each.value.iam_name
}
