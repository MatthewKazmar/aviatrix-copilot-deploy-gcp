variable "project" {
  description = "Project to deploy into. Leave at the default to use the provider defaults."
  type        = string
  default     = ""
}

variable "region" {
  description = "Region to deploy into. Leave at the default to use the provider defaults."
  type        = string
  default     = ""
}

variable "zone" {
  description = "Zone to deploy into. Leave at the default to use the provider defaults."
  type        = string
  default     = ""
}

variable "use_existing_public_ip" {
  description = "Use an existing public IP. True/false."
  type        = string
  default     = false
}

variable "public_ip_name" {
  description = "The name of the Public IP to use or deploy. Don't specify to use the default name."
  type        = string
  default     = ""
}

variable "subnet_name" {
  description = "The name of the existing subnet to deploy into. This must be in the same region as the VM."
  type        = string
}

variable "data_disk_name" {
  description = "The name of the data disk. Leave as default to autogenerate a name."
  type        = string
  default     = ""
}

variable "data_disk_size" {
  description = "The size of the data disk in GB to deploy for storage."
  type        = number
  default     = 2000
}

variable "tags" {
  description = "Any Network tags needed on the VM."
  type        = list(string)
  default     = null
}

variable "vm_name" {
  description = "The Copilot VM's name."
  type        = string
  default     = "aviatrix-copilot"
}

variable "vm_size" {
  description = "The Copilot VM's size. Minimum is 2cpu/4gb. n2-standard-2 is 2cpu/8gb."
  type        = string
  default     = "n2-standard-2"
}

