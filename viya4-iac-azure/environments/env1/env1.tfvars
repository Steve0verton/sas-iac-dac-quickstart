# General
prefix   = "env_abc" # unique prefix that groups cloud assets into resource groups (2 created)
location = "eastus" # Region
ssh_public_key = "~/.ssh/env_abc.pub" # Name of local file with public ssh key for connecting to the VMs
subscription_id = "XXXXXXXXXX" # Individual Azure subscription
tenant_id = "XXXXXXXXXX"  # Tenant ID
tags = { "division" = "XXXXXXXXXX",  "environment_name" = "XXXXXXXXXX", "starttime" = "0 9 * * 1-5", "stoptime" = "0 23 * * 1-5"}

# Allowed IP ranges (CIDR format)
vm_public_access_cidrs = ["XXXXXXXXXX"]
postgres_public_access_cidrs= ["XXXXXXXXXX"]

# External PostgreSQL
postgres_servers = {
  default = {
    sku_name                     = "GP_Standard_D8ds_v5"
    storage_mb                   = 65536
    backup_retention_days        = 7
    administrator_login          = "sassrv"
    administrator_password       = "XXXXXXXXXX"
    server_version               = 16
    ssl_enforcement_enabled      = true
  }
}

# AKS config
kubernetes_version         = "1.29.8"

# Ensures nodes scaled in pool are physically contained in the same proximity for faster performance (lower latency)
node_pools_availability_zone         = "1"
node_pools_proximity_placement       = false

# Default node pool
default_nodepool_vm_type             = "Standard_D8_v5"
default_nodepool_min_nodes           = 1
default_nodepool_max_nodes           = 2
default_nodepool_max_pods            = 110
default_nodepool_availability_zones  = ["1"]

# AKS Node Pools config
node_pools = {
  cas = {
    "machine_type"          = "Standard_E8ds_v5"
    "os_disk_size"          = 128
    "min_nodes"             = 3
    "max_nodes"             = 9
    "max_pods"              = 110
    "node_taints"           = ["workload.sas.com/class=cas:NoSchedule"]
    "node_labels" = {
      "workload.sas.com/class" = "cas"
    }
  },
  compute = {
    "machine_type"          = "Standard_E8ds_v5"
    "os_disk_size"          = 128
    "min_nodes"             = 1
    "max_nodes"             = 2
    "max_pods"              = 110
    "node_taints"           = ["workload.sas.com/class=compute:NoSchedule"]
    "node_labels" = {
      "workload.sas.com/class"        = "compute"
      "launcher.sas.com/prepullImage" = "sas-programming-environment"
    }
  },
  generic = {
    "machine_type" = "Standard_D8ds_v5"
    "os_disk_size" = 128
    "min_nodes"    = 3
    "max_nodes"    = 12
    "max_pods"     = 110
    "node_taints"  = ["workload.sas.com/class=stateful:NoSchedule"]
    "node_labels" = {
      "workload.sas.com/class" = "stateful"
    }
  }
}

# Jump Box
create_jump_public_ip = true
jump_vm_admin        = "jumpuser"
jump_vm_machine_type = "Standard_D2s_v5"

# Storage for SAS Viya CAS/Compute
storage_type = "standard"
# required ONLY when storage_type is "standard" to create NFS Server VM
create_nfs_public_ip = true
nfs_vm_admin         = "nfsuser"
nfs_vm_machine_type  = "Standard_D2s_v5"
nfs_raid_disk_size   = 1024
nfs_raid_disk_type   = "Standard_LRS"
nfs_raid_disk_zone   = "1"
nfs_vm_zone          = "1"

# Azure Monitor
create_aks_azure_monitor = false
