output "worker_public_ips" {
  value = module.worker-nodes.public_ip
}

output "master_public_ips" {
  value = module.master-node.public_ip
}
