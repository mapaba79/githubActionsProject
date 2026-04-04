terraform {
  required_version = ">= 1.5.0"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 6.0"
    }
  }
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

resource "oci_identity_compartment" "devops" {
  name           = "devops"
  description    = "Project devops resources"
  compartment_id = var.tenancy_ocid
}

module "network" {
  source         = "./modules/network"
  compartment_id = oci_identity_compartment.devops.id
}

module "compute" {
  source              = "./modules/compute"
  compartment_id      = var.tenancy_ocid
  subnet_id           = var.vm_subnet_id
  availability_domain = var.availability_domain
  image_id            = var.image_id
  ssh_public_key_path = var.ssh_public_key_path
}
