output "subnet_id" {
  value = oci_core_subnet.publica.id
}

output "vcn_id" {
  value = oci_core_vcn.rede.id
}
