
resource "google_compute_network" "gcp_vpc" {
  name = "gcp-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_firewall" "allow_internal" {
  name = "${var.gcp_vpc}-allow-internal"
  network = google_compute_network.gcp_vpc.name

  allow { protocol = "icmp" }
  allow { protocol = "tcp" }
  allow { protocol = "udp" }

  source_ranges = [ var.gcp_vpc_cidr ]
}

resource "google_compute_firewall" "allow_ssh" {
  name = "${var.gcp_vpc}-allow-ssh"
  network = google_compute_network.gcp_vpc.name

  allow {
    protocol = "tcp"
    ports = [ "22" ]
  }
}

resource "google_compute_subnetwork" "gcp_subnet" {
  name = "gcp-subnet"
  ip_cidr_range = var.gcp_vpc_subnet_cidr
  network = google_compute_network.gcp_vpc.name
  region = var.gcp_region
}


/* */

resource "google_compute_address" "gcp-vpn-ip" {
  name   = "gcp-vpn-ip"
  region = var.gcp_region
}

