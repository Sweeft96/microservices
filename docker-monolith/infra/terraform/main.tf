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

resource "google_compute_instance" "app" {
  name         = "docker-host"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["docker-host"]

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
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
    type  = "ssh"
    user  = "sweeft"
    agent = false
    host = "network_interface.0.access_config.0.nat_ip"
    # путь до приватного ключа
    private_key = "sweeft:${file(var.private_key_path)}"
  }

#  provisioner "file" {
#    source      = "files/puma.service"
#    destination = "/tmp/puma.service"
#  }
#
#  provisioner "remote-exec" {
#    script = "files/deploy.sh"
#  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  # Название сети, в которой действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
}
