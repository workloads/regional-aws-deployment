# The resources in this file are not required for the module itself, but
# are made available to allow for a better understanding of the module flow

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
resource "aws_key_pair" "main" {
  key_name_prefix = "${var.project_identifier}-${var.aws_region}"

  # load locally available public key
  public_key = file("~/.ssh/id_rsa.pub")
}
