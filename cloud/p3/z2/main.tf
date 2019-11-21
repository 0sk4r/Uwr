provider "google" {
  credentials = file("~/.gcp/pracownia.json")
  project     = "coral-shoreline-234300"
  region      = "europe-west3"
  zone        = "europe-west3-b"
}


resource "google_compute_network" "terraform-task2" {
  name = "terraform-task2"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnetwork-task2" {
  name = "subnetwork-task2"
  ip_cidr_range = "10.132.10.0/24"
  network = "${google_compute_network.terraform-task2.self_link}"
}

resource "google_compute_firewall" "firewall1" {
  name = "loadbalancerrule"
  network = "${google_compute_network.terraform-task2.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22", "443"]
  }
  source_ranges = ["88.156.131.231/32", "10.132.10.0/24", "89.64.58.225", "156.17.151.242" ]
  target_tags = ["load-balancer"]
}

resource "google_compute_firewall" "firewall2" {
  name = "httpserverrule"
  network = "${google_compute_network.terraform-task2.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }
  source_ranges = ["88.156.131.231/32", "89.64.58.225", "10.132.10.0/24", "156.17.151.242"]
  target_tags = ["http-server"]
}

resource "google_compute_firewall" "firewall3" {
  name = "loadbalancerrule2"
  network = "${google_compute_network.terraform-task2.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0" ]
  target_tags = ["load-balancer"]
}

module "httpservers" {
  source = "./http-server/"
  server-count = 2
  server-type = "f1-micro"
  www-folder = "./www"
  subnetwork-link = "${google_compute_subnetwork.subnetwork-task2.self_link}"
}


module "loadbalancer" {
  source = "./loadbalancer/"
  ip-list = "${module.httpservers.ip-list}"
  subnetwork-link = "${google_compute_subnetwork.subnetwork-task2.self_link}"
}



output "Servers-ip" {
  value = "${module.httpservers.ip-list}"
}

output "loadbalancer-ip" {
  value = "${module.loadbalancer.ip}"
}



