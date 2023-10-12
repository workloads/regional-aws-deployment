module "basic" {
  source = "../.."

  aws_region       = var.aws_region
  tfe_organization = "workloads"
}
