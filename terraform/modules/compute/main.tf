resource "oci_core_instance" "vm" {
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  display_name        = "devops-server"
  shape               = "VM.Standard.E2.1.Micro"
  source_details {
    source_type = "image"
    source_id   = var.image_id
  }
  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = true
  }
  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }
}
