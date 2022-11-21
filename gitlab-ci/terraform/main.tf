terraform {
  # Версия terraform
  required_version = "0.12.8"
}

provider "google" {
  # Версия провайдера
  version = "3.17.0"

  # ID проекта
  project = var.project
  region  = var.region
}

resource "google_compute_instance" "git" {
  name         = "gitlab-host"
  machine_type = "e2-medium"
  zone         = var.zone
  tags         = ["gitlab-host"]

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
      size  = "50"
    }
  }

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }

  metadata = {
    # путь до публичного ключа
    ssh-keys = "sweeft:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    user        = "sweeft"
    agent       = false
    host        = "network_interface.0.access_config.0.nat_ip"
    # путь до приватного ключа
    private_key = "sweeft:${file(var.private_key_path)}"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "http-https"

  # Название сети, в которой действует правило
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
}
 # allow {
 #   ports = ["80"]
 #   protocol = "tcp"
 # }
 #allow{
 #   ports = ["443"]
 #   protocol = "tcp"
 # }
#}
