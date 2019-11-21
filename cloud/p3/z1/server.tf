provider "google" {
  credentials = file("~/.gcp/pracownia.json")
  project     = "coral-shoreline-234300"
  region      = "europe-west3"
  zone        = "europe-west3-b"
}



resource "google_compute_network" "network1" {
  name                    = "network1"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork1" {
  name          = "subnetwork1"
  ip_cidr_range = "10.132.4.0/24"
  network       = "${google_compute_network.network1.self_link}"

}

resource "google_compute_firewall" "allowwww" {
  name    = "allowwww"
  network = "${google_compute_network.network1.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]

}

resource "google_compute_firewall" "allowssh" {
  name    = "allowssh"
  network = "${google_compute_network.network1.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["88.156.131.231/32", "156.17.151.242/32"]
}

// A single Google Cloud Engine instance
resource "google_compute_instance" "www-serwer" {
  name         = "terraform-www"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }


  network_interface {
    subnetwork = "${google_compute_subnetwork.subnetwork1.self_link}"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  metadata = {
    ssh-keys = "terraform:${file("~/.ssh/id_rsa.pub")}"
  }

  tags = ["http-server"]
}

module "database" {
  source = "./db_modules/"
  server_public_ip = "${google_compute_instance.www-serwer.network_interface.0.access_config.0.nat_ip}"
  main_server_name = "${google_compute_instance.www-serwer.name}"
  network = "${google_compute_network.network1.name}"

}

output "server-ip" {
  value = "${google_compute_instance.www-serwer.network_interface.0.access_config.0.nat_ip}"
}

output "db-ip" {
  value = "${module.database.database-ip}"
}

