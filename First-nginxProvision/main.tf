resource "yandex_compute_instance" "default" {
  name        = "otus-learn-1"
  platform_id = "standard-v1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8go38kje4f6v3g2k4q"
    }

  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.custom_subnet.id
    security_group_ids = [yandex_vpc_security_group.my_webserver.id]
    nat                = true
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i hosts  nginx.yml"
  }
}

resource "yandex_vpc_network" "custom_vpc" {
  name = "custom_vpc"

}
resource "yandex_vpc_subnet" "custom_subnet" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.custom_vpc.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}



resource "yandex_vpc_security_group" "my_webserver" {
  name        = "WebServer security group"
  description = "My Security group"
  network_id  = yandex_vpc_network.custom_vpc.id

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "Outcoming traf"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = -1
  }
}
