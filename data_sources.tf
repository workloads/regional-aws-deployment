# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones
data "aws_availability_zones" "main" {
  # only return available AZs (omitting impaired and unavailable ones)
  state = "available"

  # filter by Zone Type for AZs (and therefore exclude special AZs such as Wavelength)
  # CLI Command: `aws --region="${AWS_REGION}" ec2 describe-availability-zones --filter="Name=zone-type,Values=['availability-zone']"`
  # see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones#filter
  filter {
    name = "zone-type"

    values = [
      "availability-zone"
    ]
  }
}

# TODO: replace with HCP Packer-managed resource
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
data "aws_ami" "main" {
  most_recent = true

  filter {
    name = "virtualization-type"

    values = [
      "hvm"
    ]
  }

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    ]
  }

  owners = [
    "679593333241" # Canonical
  ]
}
