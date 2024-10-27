resource "google_compute_instance" "frontend" {
  name         = "frontend"
  machine_type = "e2-micro"
  zone         = var.zone
  tags         = ["http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    "startup-script" = file("startup-script/frontend.sh")
  }
}

resource "google_compute_instance" "backend" {
  name         = "backend"
  machine_type = "e2-micro"
  zone         = var.zone
  tags         = ["http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    "startup-script" = file("startup-script/backend.sh")
  }
}
