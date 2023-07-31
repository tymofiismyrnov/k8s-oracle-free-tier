resource "oci_load_balancer_load_balancer" "kube_load_balancer" {
    #Required
    compartment_id = var.tenancy_ocid
    display_name = "kube_load_balancer"
    shape = "flexible"
    subnet_ids = [oci_core_subnet.kube_subnet.id]

    #Optional
    ip_mode = "IPV4"
    is_private = false
    network_security_group_ids = [oci_core_network_security_group.kubevcn_sg.id]
    shape_details {
        #Required
        maximum_bandwidth_in_mbps = 10
        minimum_bandwidth_in_mbps = 10
    }
}

resource "oci_load_balancer_backend" "master_node_backend" {
    #Required
    backendset_name = oci_load_balancer_backend_set.kube_lb_bs.name
    ip_address = module.master-node.private_ip[0]
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    port = 32080
}

resource "oci_load_balancer_backend" "worker_node_1_backend" {
    #Required
    backendset_name = oci_load_balancer_backend_set.kube_lb_bs.name
    ip_address = module.worker-nodes.private_ip[0]
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    port = 32080
}

resource "oci_load_balancer_backend" "worker_node_2_backend" {
    #Required
    backendset_name = oci_load_balancer_backend_set.kube_lb_bs.name
    ip_address = module.worker-nodes.private_ip[1]
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    port = 32080
}

resource "oci_load_balancer_backend_set" "kube_lb_bs" {
    #Required
    health_checker {
        #Required
        protocol = "TCP"

        #Optional
        interval_ms = 10000
        port = 22
        retries = 3
        timeout_in_millis = 3000
    }
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    name = "kube_lb_bs"
    policy = "ROUND_ROBIN"

}

resource "oci_load_balancer_listener" "test_listener" {
    #Required
    default_backend_set_name = oci_load_balancer_backend_set.kube_lb_bs.name
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    name = "http_listener"
    port = 80
    protocol = "HTTP"
}
