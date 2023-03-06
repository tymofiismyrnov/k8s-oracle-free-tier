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

To prevent ansible from prompting 'known_hosts' add the following to the /etc/ansible/ansible.cfg
[defaults]
host_key_checking = False

