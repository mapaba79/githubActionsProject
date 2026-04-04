terraform {
  required_version = ">= 1.5.0"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 6.0"
    }
  }

  backend "http" {
    address        = "https://gr3pbpm9uygn.objectstorage.sa-saopaulo-1.oci.customer-oci.com/p/qE6Q7MjAejbewLGPUEjJjdv6K6sb9Epp_HhpnphcAENBFTcf3SPNSdCvJVav-nEF/n/gr3pbpm9uygn/b/terraform-state/o/terraform.tfstate"
    update_method  = "PUT"
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

resource "oci_objectstorage_bucket" "tfstate" {
  compartment_id = oci_identity_compartment.devops.id
  namespace      = "gr3pbpm9uygn"
  name           = "terraform-state"
  access_type    = "NoPublicAccess"
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
