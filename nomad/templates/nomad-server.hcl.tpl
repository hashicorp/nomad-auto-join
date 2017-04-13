# Enable the server
data_dir   = "/mnt/nomad"

server {
    enabled = true

    # Self-elect, should be 3 or 5 for production
    bootstrap_expect = ${instances}
}

telemetry {
  publish_allocation_metrics = true
  publish_node_metrics       = true
}
