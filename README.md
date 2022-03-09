# Aviatrix CoPilot for GCP

### Description
This module deploys Aviatrix CoPilot 1.6.1 in GCP with necessary data disk.
https://docs.aviatrix.com/HowTos/copilot_getting_started.html#instance-system-requirements

Defaults include a 2TB data disk and an n2-standard-2 (2 CPU/8gb RAM) VM instance.

### Compatibility
Module version | Terraform version | Controller version | Terraform provider version
:--- | :--- | :--- | :---
v1.0.0 | 0.12 - 1.0 | >=6.5 | >=0.2.20

### Usage Example

```
module "aviatrix-copilot-deploy-gcp" {
  source        = "terraform-aviatrix-modules/copilot/aviatrix"
  version       = "1.0.0"

  subnet_name   = "aviatrix-copilot"
}
```

```
module "aviatrix-copilot-deploy-gcp" {
  source          = "terraform-aviatrix-modules/copilot/aviatrix"
  version         = "1.0.0"

  subnet_name     = "aviatrix-copilot"
  vm_name         = "copilot"
  data_disk_size  = 4000 #4tb data disk
  vm_size         = "n2-standard-8" #8 cpu/32gb
}
```

### Variables
The following variables are required:

key | value
--- | ---
subnet_name | The name of the existing subnet to deploy into. This must be in the same region as the VM.

The following variables are optional:

key | default | value
:--- | :--- | :---
project | Provider default | Project to deploy into. 
region | Provider default | Region to deploy into.
zone | Provider default | Zone to deploy into.
use_existing_public_ip | false | Use an existing public IP.
public_ip_name | <vm_name>-public-ip | The name of the Public IP to use or deploy.
data_disk_size | 2000 (2tb) | The size of the data disk in GB to deploy for storage.
tags | null | Network tags to apply to the VM.
vm_name | aviatrix-copilot |The Copilot VM's name.
vm_size | n2-standard-2 | The Copilot VM's size. Minimum is 2cpu/4gb.
