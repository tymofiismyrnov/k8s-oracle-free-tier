module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.5.3"
  # insert the 5 required variables here

  # Required Inputs
  compartment_id = var.compartment_ocid
  region         = var.region

  internet_gateway_route_rules = null
  local_peering_gateways       = null
  nat_gateway_route_rules      = null

  # Optional Inputs
  vcn_name      = var.network_names.vcn_name
  vcn_dns_label = var.network_names.vcn_name
  vcn_cidrs     = [var.network_settings.vcn_cidr]

  create_internet_gateway = true
  create_nat_gateway      = false
  create_service_gateway  = false

  lockdown_default_seclist = true
}


resource "oci_core_subnet" "kube_subnet" {
  vcn_id            = module.vcn.vcn_id
  cidr_block        = var.network_settings.subnet_cidr
  display_name      = var.network_names.subnet_name
  dns_label         = var.network_names.subnet_name
  compartment_id    = var.compartment_ocid
  security_list_ids = [oci_core_security_list.kube_security_list.id]
  route_table_id    = module.vcn.ig_route_id

}
