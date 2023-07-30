# Requrements 
Terraform v1.3.5
Ansible
jq

### Terraform ###
Terraform v1.3.5


### Ansible ###
If Windows - use WSL.
Don't forget to copy your id_rsa to the WSL and change permissions
sudo cp /c/mnt/Users/{username}/.ssh/id_rsa ~/.ssh/ && sudo chmod 600 ~/.ssh/id_rsa # 

Installation:
sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible -y


### Manual ###

After applying terraform and ansible
SSH on the master nod and install ingress controller
- kubectl create ns ingress-nginx
- helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
- helm repo update
- helm install nginx-ingress ingress-nginx/ingress-nginx -n ingress-nginx --values ingress-values.yaml

ingress-values.yaml file can be found in /kubernetes/nginx-ingress folder

