# Deploy Aviatrix Copilot in GCP

# Get default project/region/zone.
data "google_client_config" "cc" {}

locals {
  project        = var.project == "" ? data.google_client_config.cc.project : var.project
  region         = var.region == "" ? data.google_client_config.cc.region : var.region
  zone           = var.zone == "" ? data.google_client_config.cc.zone : var.zone
  public_ip_name = var.public_ip_name == "" ? "${var.vm_name}-public-ip" : var.public_ip_name
  public_ip      = var.use_existing_public_ip ? data.google_compute_address.avx_copilot_publicip.address : google_compute_address.avx_copilot_publicip.address
  data_disk_name = var.data_disk_name == "" ? "${var.vm_name}-data-disk-1" : var.data_disk_name
}

resource "google_compute_address" "avx_copilot_publicip" {
  count        = var.use_existing_public_ip ? 0 : 1
  name         = var.public_ip_name
  address_type = "EXTERNAL"
  project      = local.project
  region       = local.region
}

data "google_compute_address" "avx_copilot_publicip" {
  count   = var.use_existing_public_ip ? 1 : 0
  name    = local.public_ip_name
  project = local.project
  region  = local.region
}

data "google_compute_subnetwork" "avx_copilot_subnet" {
  name    = var.subnet_name
  project = local.project
  region  = local.region
}

resource "google_compute_disk" "data_disk" {
  name = local.data_disk_name
  size = var.data_disk_size
  type = "pd-ssd"
}


resource "google_compute_instance" "avx_copilot_vm" {
  name                      = var.vm_name
  machine_type              = var.vm_size #"n2-standard-2" # https://docs.aviatrix.com/HowTos/copilot_getting_started.html#instance-system-requirements
  zone                      = local.zone
  tags                      = var.tags
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "aviatrix-public/avx-copilot-gcp-1-6-1-2022-01-27"
    }
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.extranet-avx-controller.self_link
    access_config {
      nat_ip = local.public_ip
    }
  }

  attached_disk {
    source = google_compute_disk.data_disk.self_link
  }

}