variable "subnetwork-link" {
  description = "self-link of the subnetwork to create servers in"
}
variable "ip-list" {
  type = "list"
  description = "ip list"
}

resource "google_compute_address" "public_ip" {
  name         = "server-ip-loadbalancer"
  address_type = "EXTERNAL"
}

resource "google_compute_instance" "loadbalancer" {

  machine_type  = "f1-micro"
  name = "terraform-loadbalancer"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    subnetwork = "${var.subnetwork-link}"
    access_config {
      nat_ip = "${google_compute_address.public_ip.address}"
    }
  }

   metadata = {
    ssh-keys = "oskar:${file("~/.ssh/id_rsa.pub")}"
  }

  tags = ["load-balancer", "http-server"]

  provisioner "local-exec" {
    command = "echo ${google_compute_address.public_ip.address} > ./ansible/hosts"
  }

  provisioner "local-exec" {
    command = "ssh-keygen -f /Users/oskar/.ssh/known_hosts -R ${google_compute_address.public_ip.address}"
  }

  provisioner "local-exec" {
    command = "ansible-playbook --key-file '~/.ssh/id_rsa' ./ansible/loadbalancer.yml -i ./ansible/hosts --extra-vars '{ip_list: [${join(",", var.ip-list)}]}' "
  }
}

output "ip" {
  value = "${google_compute_address.public_ip.address}"
}


//ssh -o sctricthostkeychecking
//plik ansible.cfg - w tym flagi do ssh