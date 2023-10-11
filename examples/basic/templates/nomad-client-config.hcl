# see https://developer.hashicorp.com/nomad/docs/configuration#general-parameters
bind_addr                   = "0.0.0.0"
data_dir                    = "/tmp/nomad/data"
datacenter                  = "${datacenter}"
disable_anonymous_signature = false
disable_update_check        = false
enable_debug                = false
enable_syslog               = false
leave_on_interrupt          = false
leave_on_terminate          = false
log_json                    = false
log_level                   = "INFO"
log_rotate_bytes            = 0
log_rotate_max_files        = 0
region                      = "${region}"
syslog_facility             = "LOCAL0"
# end of general section

# see https://developer.hashicorp.com/nomad/docs/configuration/client
client {
  alloc_dir                   = "/tmp/nomad/data/alloc"
  bridge_network_hairpin_mode = false
  bridge_network_name         = "nomad"
  bridge_network_subnet       = "172.26.64.0/20"
  cgroup_parent               = "/nomad"
  cni_config_dir              = "/opt/cni/config"
  cni_path                    = "/opt/cni/bin"
  cpu_total_compute           = 0
  disable_remote_exec         = false
  disk_free_mb                = 0
  disk_total_mb               = 0
  enabled                     = true
  gc_inode_usage_threshold    = 70
  gc_interval                 = "1m"
  gc_max_allocs               = 50
  gc_parallel_destroys        = 2
  max_dynamic_port            = 32000
  max_kill_timeout            = "30s"
  memory_total_mb             = 0
  min_dynamic_port            = 20000
  no_host_uuid                = true
  servers                     = []
  state_dir                   = "/opt/nomad/client"
}
# end of `client` section

# section `consul` was omitted because it was inactive at generation time
# see https://developer.hashicorp.com/nomad/docs/configuration/server
server {
  acl_token_gc_threshold        = "1h"
  batch_eval_gc_threshold       = "24h"
  bootstrap_expect              = 1
  csi_plugin_gc_threshold       = "1h"
  csi_volume_claim_gc_interval  = "5m"
  csi_volume_claim_gc_threshold = "1h"
  data_dir                      = "/opt/nomad/data/server"
  deployment_gc_threshold       = "1h"
  enable_event_broker           = true
  enabled                       = false
  eval_gc_threshold             = "1h"
  event_buffer_size             = 100
  failover_heartbeat_ttl        = "5m"
  heartbeat_grace               = "10s"
  job_default_priority          = 50
  job_gc_interval               = "5m"
  job_gc_threshold              = "4h"
  job_max_priority              = 100
  job_max_source_size           = "1M"
  max_heartbeats_per_second     = 50.0
  min_heartbeat_ttl             = "10s"
  node_gc_threshold             = "24h"
  non_voting_server             = false
  num_schedulers                = 1

  retry_join = [
    "${join_tags}"
  ]

  rejoin_after_leave          = false
  root_key_gc_interval        = "10m"
  root_key_gc_threshold       = "1h"
  root_key_rotation_threshold = "720h"

  start_join = [
    "${join_tags}",
  ]
}
# end of `server` section

# section `ui` was omitted because it was inactive at generation time

# section `vault` was omitted because it was inactive at generation time
# see https://developer.hashicorp.com/nomad/docs/drivers/docker
plugin "docker" {
  # see https://developer.hashicorp.com/nomad/docs/drivers/docker#allow_privileged
  allow_privileged = true

  # see https://developer.hashicorp.com/nomad/docs/drivers/docker#plugin-options
  config {
    # see https://developer.hashicorp.com/nomad/docs/drivers/docker#extra_labels
    extra_labels = [
      "nomad_job_name",
      "job_id",
      "task_name"
    ]

    # see https://developer.hashicorp.com/nomad/docs/drivers/docker#gc
    gc {
      image       = true
      image_delay = "3m"
      container   = true

      dangling_containers {
        enabled        = true
        dry_run        = false
        period         = "5m"
        creation_grace = "5m"
      }
    }

    # see https://developer.hashicorp.com/nomad/docs/drivers/docker#volumes-1
    volumes {
      enabled = true
    }
  }
}

# see https://developer.hashicorp.com/nomad/docs/drivers/raw_exec
plugin "raw_exec" {
  # see https://developer.hashicorp.com/nomad/docs/drivers/docker#allow_privileged
  enabled = true

  # see https://developer.hashicorp.com/nomad/docs/drivers/raw_exec#driver-raw_exec-no_cgroups
  no_cgroups = false
}
