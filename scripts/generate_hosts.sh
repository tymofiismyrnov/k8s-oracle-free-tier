#!/bin/bash

ansible_user='ubuntu'
hosts_file="../ansible/hosts"
terraform_dir="../terraform/"
worker_count=$(terraform -chdir=$terraform_dir output -json worker_public_ips | jq length)
master_count=$(terraform -chdir=$terraform_dir output -json master_public_ips | jq length)

# Empty hosts file if exists
> $hosts_file

function print_ansible_hosts() {
    local count=$1
    local group_name=$2
    echo "[${group_name}s]" | tee -a $hosts_file
    for ((i = 0; i < $count; i++)); do
        result=$(terraform -chdir=${terraform_dir} output -json ${group_name}_public_ips | jq -r ".[${i}]")
        j=$((i + 1))
        echo "${group_name}${j} ansible_host=${result} ansible_user=${ansible_user}" | tee -a $hosts_file
    done
    echo "" | tee -a $hosts_file
}

print_ansible_hosts $master_count master
print_ansible_hosts $worker_count worker
