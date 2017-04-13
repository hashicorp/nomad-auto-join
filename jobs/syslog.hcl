job "system_utils" {
  datacenters = ["dc1"]
  type        = "system"

  update {
    stagger      = "10s"
    max_parallel = 1
  }

  group "system_utils" {
    constraint {
      distinct_hosts = true
    }

    restart {
      attempts = 10
      interval = "5m"
      delay    = "25s"
      mode     = "delay"
    }

    task "syslog" {
      driver = "docker"

      config {
        image = "balabit/syslog-ng:latest"

        port_map {
          udp = 514
          tcp = 601
        }
      }

      resources {
        cpu    = 500 # 500 MHz
        memory = 256 # 256MB

        network {
          mbits = 10

          port "udp" {
            static = "514"
          }

          port "tcp" {
            static = "601"
          }
        }
      }
    }
  }
}
