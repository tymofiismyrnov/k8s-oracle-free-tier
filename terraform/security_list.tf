resource "oci_core_security_list" "kube_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = module.vcn.vcn_id
  display_name   = var.network_names.security_list_name


  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  ingress_security_rules {
    description = "Allow SSH from any"
    protocol  = "6" // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      min = 22
      max = 22
    }
  }

    ingress_security_rules {
    description = "Allow HTTP from any"
    protocol  = "6" // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      min = 80
      max = 80
    }
  }

    ingress_security_rules {
    description = "Allow HTTPS from any"
    protocol  = "6" // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      min = 443
      max = 443
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

    ingress_security_rules {
    description = "Allow All My IP"
    protocol    = "all"
    source      = var.my_ip
    stateless   = false
  }

    ingress_security_rules {
      description = "Allow All internal"
      protocol = "all"
      source = var.network_settings.subnet_cidr
      stateless = false
    }
}

resource "oci_core_network_security_group" "kubevcn_sg" {
  #Required
  compartment_id = var.compartment_ocid
  vcn_id         = module.vcn.vcn_id

  #Optional
  display_name = "kubevcn_sg"

}

resource "oci_core_network_security_group_security_rule" "allow_egress" {
  network_security_group_id = oci_core_network_security_group.kubevcn_sg.id
  direction                 = "EGRESS"
  protocol                  = "all"
  destination_type          = "CIDR_BLOCK"
  destination               = "0.0.0.0/0"
}
