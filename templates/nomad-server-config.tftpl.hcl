# see https://developer.hashicorp.com/nomad/docs/configuration#general-parameters
bind_addr                   = "0.0.0.0"
data_dir                    = "/opt/nomad/data"
datacenter                  = "${datacenter}"
disable_anonymous_signature = false
disable_update_check        = false
enable_debug                = false
enable_syslog               = false
leave_on_interrupt          = false
leave_on_terminate          = true
log_json                    = false
log_level                   = "INFO"
log_rotate_bytes            = 0
log_rotate_max_files        = 0
region                      = "${region}"
syslog_facility             = "LOCAL0"
# end of general section

# see https://developer.hashicorp.com/nomad/docs/configuration/server
server {
  acl_token_gc_threshold        = "1h"
  authoritative_region          = "${authoritative_region}"
  batch_eval_gc_threshold       = "24h"
  bootstrap_expect              = 3
  csi_plugin_gc_threshold       = "1h"
  csi_volume_claim_gc_interval  = "5m"
  csi_volume_claim_gc_threshold = "1h"
  data_dir                      = "/opt/nomad/data/server"
  deployment_gc_threshold       = "1h"
  enable_event_broker           = true
  enabled                       = true
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
  rejoin_after_leave            = true
  root_key_gc_interval          = "10m"
  root_key_gc_threshold         = "1h"
  root_key_rotation_threshold   = "720h"

  server_join = {
    retry_interval = "15s"

    retry_join = ${jsonencode(join_tags)}

    retry_max = 9
  }
}
# end of `server` section

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
