resource "oci_core_vcn" "rede" {
  compartment_id = var.compartment_id
  display_name   = "devops-vcn"
  cidr_blocks    = ["10.0.0.0/16"]
  dns_label      = "devopsvcn"
}

resource "oci_core_internet_gateway" "gateway" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.rede.id
  display_name   = "gateway"
  enabled        = true
}

resource "oci_core_route_table" "rt" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.rede.id
  display_name   = "devops-rt"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.gateway.id
  }
}

resource "oci_core_security_list" "sl" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.rede.id
  display_name   = "devops-sl"
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 22
      max = 22
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 80
      max = 80
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 443
      max = 443
    }
  }
  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}

resource "oci_core_subnet" "publica" {
  compartment_id    = var.compartment_id
  vcn_id            = oci_core_vcn.rede.id
  cidr_block        = "10.0.1.0/24"
  display_name      = "devops-subnet"
  dns_label         = "devopssubnet"
  route_table_id    = oci_core_route_table.rt.id
  security_list_ids = [oci_core_security_list.sl.id]
}
