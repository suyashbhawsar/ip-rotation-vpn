provider "google" {
 credentials = file("/Users/suyash/Downloads/ip-address-rotation.json")
 project   = "ip-address-rotation"
 region   = "us-central1"
}

variable "zones" {
 type = list(string)
 default = ["us-central1-b", "europe-west4-b", "europe-west2-c"]
}

resource "google_compute_instance" "vpn_server" {
 count = 3
 name = "vpn-server-${count.index}"
 machine_type = "g1-small"
 zone = var.zones[count.index]


 boot_disk {
  initialize_params {
   image = "projects/debian-cloud/global/images/family/debian-12"
  }
 }

 network_interface {
  network = "default"
  access_config {
  }
 }

 metadata = {
  ssh-keys = "suyash:${file("~/.ssh/id_rsa.pub")}"
 }
}
