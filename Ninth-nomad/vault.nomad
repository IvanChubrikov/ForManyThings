job "vault-cluster" {
  datacenters = ["dc1"]
  type = "service"

  group "vault" {
    count = 3

    task "vault" {
      driver = "docker"
      config {
        image = "vault:latest"
        command = ["server", "-config", "/vault/config/vault.hcl"]
        ports = ["api"]
        volumes = [
          "vault-config:/vault/config",
          "vault-data:/vault/data",
        ]
        env {
          VAULT_API_ADDR = "http://0.0.0.0:8200"
        }
      }

      resources {
        cpu    = 500 # 500 MHz
        memory = 512 # 512MB
        network {
          mbits = 10
          port "api" {}
        }
      }

      template {
        data = <<EOF
backend "consul" {
  address = "127.0.0.1:8500"
  path    = "vault"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}

storage "consul" {
  address = "127.0.0.1:8500"
  path    = "vault"
}

seal "awskms" {
  region = "us-west-2"
  kms_key_id = "<your-kms-key-id>"
}

ui = true
EOF
        destination = "vault.hcl"
      }

      service {
        name = "vault"
        port = "api"
        check {
          type     = "http"
          path     = "/v1/sys/health"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }

  volume "vault-config" {
    type      = "host"
    read_only = true
    source    = "/etc/vault.d/"
  }

  volume "vault-data" {
    type      = "host"
    read_only = false
    source    = "/var/vault/data/"
  }

  periodic {
    name        = "db-password-update"
    cron        = "*/2 * * * *"
    prohibit_overlap = true
    job_spec {
      name = "db-password-update"
      datacenters = ["dc1"]
      type = "batch"
      priority = 50
      constraint {
        attribute = "${attr.kernel.name}"
        value     = "linux"
      }
      task "update" {
        driver = "docker"
        config {
          image = "vault:latest"
          command = ["vault", "write", "database/config/mydb", "password=mynewpassword"]
        }
      }
    }
  }
}

