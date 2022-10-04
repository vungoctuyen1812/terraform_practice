/* resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

locals {
  private_key_pem = nonsensitive(tls_private_key.pk.private_key_pem)
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.keyname
  public_key = tls_private_key.pk.public_key_openssh
  provisioner "local-exec" {
    command = <<EOT
      del /f ${var.keyname}.pem
      echo ${local.private_key_pem} > ${var.keyname}.pem
    EOT
  }
} */

module "ssh_key_pair" {
  source                = "cloudposse/key-pair/aws"
  version               = "0.18.3"
  stage                 = var.stage
  name                  = var.keyname
  ssh_public_key_path   = "."
  generate_ssh_key      = "true"
  private_key_extension = ".pem"
  public_key_extension  = ".pub"
}
