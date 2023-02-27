resource "oci_core_security_list" "kube_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = module.vcn.vcn_id
  display_name   = var.network_names.security_list_name


  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  ingress_security_rules {
    protocol  = "6" // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      min = 22
      max = 22
    }
  }


  ingress_security_rules {
    description = "Allow ICMP"
    protocol    = 1
    source      = "0.0.0.0/0"
    stateless   = false

    icmp_options {
      type = 8
    }
  }
}
