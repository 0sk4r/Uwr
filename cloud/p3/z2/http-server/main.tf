variable "server-count" {
  default     = 1
  description = "Number of servers to create"
}
variable "server-type" {
  default     = "f1-micro"
  description = "type of server"
}

variable "www-folder" {
  description = "source of www files"
}
variable "subnetwork-link" {
  description = "self-link of the subnetwork to create servers in"
}

resource "google_compute_address" "public_ip" {
  count        = "${var.server-count}"
  name         = "server-public-ip-${count.index}"
  address_type = "EXTERNAL"
}

resource "google_compute_address" "private_ip" {
  count        = "${var.server-count}"
  name         = "server-private-ip-${count.index}"
  subnetwork   = "${var.subnetwork-link}"
  address_type = "INTERNAL"
}

resource "google_compute_instance" "httpservers" {

  count        = "${var.server-count}"
  machine_type = "${var.server-type}"
  name         = "www-server-${count.index}"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  metadata = {
    ssh-keys = "terraform:${file("~/.ssh/id_rsa.pub")}"
  }

  network_interface {
    subnetwork = "${var.subnetwork-link}"
    network_ip = "${element(google_compute_address.private_ip.*.address, count.index)}"

    access_config {
      nat_ip = "${element(google_compute_address.public_ip.*.address, count.index)}"
    }
  }

  tags = ["http-server"]

  connection {
    type        = "ssh"
    host        = "${element(google_compute_address.public_ip.*.address, count.index)}"
    user        = "terraform"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install nginx",
    ]
  }
  provisioner "local-exec" {
    command = <<SCRIPT
    scp -o StrictHostKeyChecking=no ${var.www-folder}/index.html ${element(google_compute_address.public_ip.*.address, count.index)}:index.html
    ssh -o StrictHostKeyChecking=no ${element(google_compute_address.public_ip.*.address, count.index)} -- sudo cp index.html /var/www/html/index.html
    SCRIPT
  }
}

output "ip-list" {
  value = "${google_compute_address.private_ip.*.address}"
}

output "test" {
  value = "${google_compute_address.private_ip.*}"
}
