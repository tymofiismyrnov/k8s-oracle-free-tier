module "worker-nodes" {
  source                      = "oracle-terraform-modules/compute-instance/oci"
  instance_count              = var.worker_node_settings.instance_count
  ad_number                   = var.worker_node_settings.availability_domain_number
  compartment_ocid            = var.compartment_ocid
  instance_display_name       = var.worker_node_settings.instance_name
  source_ocid                 = var.source_image_id
  subnet_ocids                = [oci_core_subnet.kube_subnet.id]
  private_ips                 = var.worker_node_settings.private_ips
  public_ip                   = var.public_ip_type
  ssh_public_keys             = file(var.ssh_file_path)
  boot_volume_size_in_gbs     = 50
  shape                       = var.vm_shape
  instance_flex_memory_in_gbs = 6
  instance_flex_ocpus         = 1
  instance_state              = var.instance_state
  boot_volume_backup_policy   = var.boot_backup_policy
  preserve_boot_volume        = false
}

module "master-node" {
  source                      = "oracle-terraform-modules/compute-instance/oci"
  instance_count              = var.master_node_settings.instance_count
  ad_number                   = var.master_node_settings.availability_domain_number
  compartment_ocid            = var.compartment_ocid
  instance_display_name       = var.master_node_settings.instance_name
  source_ocid                 = var.source_image_id
  subnet_ocids                = [oci_core_subnet.kube_subnet.id]
  private_ips                 = var.master_node_settings.private_ips
  public_ip                   = var.public_ip_type
  ssh_public_keys             = file(var.ssh_file_path)
  boot_volume_size_in_gbs     = 50
  shape                       = var.vm_shape
  instance_flex_memory_in_gbs = 6
  instance_flex_ocpus         = 2
  instance_state              = var.instance_state
  boot_volume_backup_policy   = var.boot_backup_policy
  preserve_boot_volume        = false
}

