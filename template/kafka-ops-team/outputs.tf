output "staging-resource-ids" {
  value = <<-EOT

  ====

  Staging Environment ID:   ${module.staging_environment.id}
  Staging Schema Registry ID:   ${module.staging_environment.schema_registry_cluster.id}
  Staging Schema Registry Rest Endpoint:   ${module.staging_environment.schema_registry_cluster.rest_endpoint}
  Staging MetricsViewer API Key: ${module.staging_environment.env_metrics_viewer_api_key.id}:${module.staging_environment.env_metrics_viewer_api_key.secret}
  Staging EnvironmentAdmin/AccountAdmin API Key:  ${module.staging_environment.env_admin_api_key.id}:${module.staging_environment.env_admin_api_key.secret}

  EOT

  sensitive = true
}
