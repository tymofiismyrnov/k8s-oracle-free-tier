variable "tenancy_ocid" {
  type        = string
  description = "Get on API key creation"
}

variable "user_ocid" {
  type        = string
  description = "Get on API key creation"
}

variable "fingerprint" {
  type        = string
  description = "Get on API key creation"
}

variable "private_key_path" {
  type        = string
  description = "Get on API key creation"
}

variable "compartment_ocid" {
  type        = string
  description = "Get on API key creation"
}

variable "region" {
  type = string
}

variable "source_image_id" {
  type        = string
  description = "OS image OCID"
  default     = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaacrj6oowfieuvdqxcwv54qqjh7gnjk6grv2pru3lmrynqz36yp6ja"
}

variable "network_names" {
  description = "Network instances names stored in a single variable"
  type        = map(string)
  default = {
    "vcn_name"           = "kubevcn"
    "subnet_name"        = "kubesubnet"
    "security_list_name" = "kube_security_list"
  }
}

variable "network_settings" {
  description = "Network settings"
  type        = map(string)
  default = {
    "vcn_cidr"    = "10.0.0.0/16"
    "subnet_cidr" = "10.0.1.0/24"
  }
}

variable "ssh_file_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "worker_node_settings" {
  type = object({
    instance_count             = number
    availability_domain_number = number
    instance_name              = string
    private_ips                = list(string)
  })
  default = {
    "instance_count"             = 2    # how many instances do you want?
    "availability_domain_number" = null # AD number to provision instances. If null, instances are provisionned in a rolling manner starting with AD1
    "instance_name"              = "worker"
    "private_ips"                = ["10.0.1.100", "10.0.1.101"]
  }
}

variable "master_node_settings" {
  type = object({
    instance_count             = number
    availability_domain_number = number
    instance_name              = string
    private_ips                = list(string)
  })
  default = {
    "instance_count"             = 1 # how many instances do you want?
    "availability_domain_number" = null # AD number to provision instances. If null, instances are provisionned in a rolling manner starting with AD1
    "instance_name"              = "master"
    "private_ips"                = ["10.0.1.200"]
  }
}


variable "public_ip_type" {
  type    = string
  default = "EPHEMERAL" # NONE, RESERVED or EPHEMERAL
}

variable "vm_shape" {
  type    = string
  default = "VM.Standard.A1.Flex"
}

variable "instance_state" {
  type    = string
  default = "RUNNING" # RUNNING or STOPPED
}

variable "boot_backup_policy" {
  type    = string
  default = "gold" # disabled, gold, silver or bronze
}
