# TODO: switch to Auto Scaling Group
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "main" {
  for_each = local.targets

  ami = data.aws_ami.main.id

  associate_public_ip_address = true
  availability_zone           = each.key
  ebs_optimized               = true

  # TODO
  # iam_instance_profile = "TODO"

  instance_type = "t3.micro"

  tags = {
    "Name"          = "${each.key}${local.zone_suffix}"
    "nomad:version" = "TODO"
    "nomad:primary" = "TODO"
  }
}
