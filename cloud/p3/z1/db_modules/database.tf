variable "server_public_ip" {
  description = "Public ip of the created server "
}

variable "network" {
  description = "Network name"
}

variable "main_server_name" {
  description = "name of the host server"
}


###### DATABASE ######

resource "google_sql_database_instance" "terraform-db" {
  name             = "terraform-db1233"
  database_version = "POSTGRES_9_6"

  settings {
    tier            = "db-f1-micro"
    disk_autoresize = "true"

    ip_configuration {
      ipv4_enabled = true

      authorized_networks {
        name  = "${var.network}"
        value = "${var.server_public_ip}/32"
      }

      # private_network = "${var.network.self_link}"

    }
  }
}

resource "google_sql_database" "users" {
  instance  = "${google_sql_database_instance.terraform-db.name}"
  name      = "test"
}

resource "google_sql_user" "machine-user" {
  instance  = "${google_sql_database_instance.terraform-db.name}"
  name      = "oskar"
  password  = "oskar"
  host      = "${var.server_public_ip}"
}


output "database-ip" {
  value = "${google_sql_database_instance.terraform-db.ip_address}"
}
