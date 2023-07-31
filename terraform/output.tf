output "load_balancer_public_ip" {
  value = oci_load_balancer_load_balancer.kube_load_balancer.ip_address_details[0].ip_address
}

output "worker_public_ips" {
  value = module.worker-nodes.public_ip
}

output "master_public_ips" {
  value = module.master-node.public_ip
}

