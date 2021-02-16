
resource "google_compute_network" "gcp-vpc" {
  name                    = "gcp-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "gcp-subnet1" {
  name          = "gcp-subnet1"
  ip_cidr_range = var.gcp_vpc_subnet_cidr
  network       = google_compute_network.gcp-vpc.name
  region        = var.gcp_region
}

