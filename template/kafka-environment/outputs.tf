output "resource-ids" {
  value = <<-EOT

  ====

  ${title(module.staging_environment.confluent_environment.display_name)} Environment ID:   ${module.staging_environment.id}
  ${title(module.staging_environment.confluent_environment.display_name)} Schema Registry ID:   ${module.staging_environment.schema_registry_cluster.id}
  ${title(module.staging_environment.confluent_environment.display_name)} Schema Registry Rest Endpoint:   ${module.staging_environment.schema_registry_cluster.rest_endpoint}
  ${title(module.staging_environment.confluent_environment.display_name)} MetricsViewer API Key: ${module.staging_environment.env_metrics_viewer_api_key.id}:${module.staging_environment.env_metrics_viewer_api_key.secret}
  ${title(module.staging_environment.confluent_environment.display_name)} EnvironmentAdmin/AccountAdmin API Key:  ${module.staging_environment.env_admin_api_key.id}:${module.staging_environment.env_admin_api_key.secret}

  ${title(module.customer_cluster.confluent_kafka_cluster.display_name)} Cluster ID: ${module.customer_cluster.id}
  ${title(module.customer_cluster.confluent_kafka_cluster.display_name)} Flink Compute Pool ID: ${module.customer_cluster.flink_compute_pool_id}
  ${title(module.customer_cluster.confluent_kafka_cluster.display_name)} Cluster Admin: "${module.customer_cluster.cluster_admin_api_key.id}:${module.customer_cluster.cluster_admin_api_key.secret}"

  ****************************
  Metrics Scrape Job Configs
  ****************************
  Flink Scrape Job URL:   https://api.telemetry.confluent.cloud/v2/metrics/cloud/export?resource.compute_pool.id=${module.customer_cluster.flink_compute_pool_id}
  Cluster Scrape Job URL: https://api.telemetry.confluent.cloud/v2/metrics/cloud/export?resource.kafka.id=${module.customer_cluster.id}

  **************
  Client Configs
  **************

  "bootstrap.servers": "${module.customer_cluster.confluent_kafka_cluster.bootstrap_endpoint}",

  # ${title(module.customer_cluster.developer_write_service_account.display_name)} sasl jaas config
  "sasl.jaas.config": "org.apache.kafka.common.security.plain.PlainLoginModule required username='${module.customer_cluster.developer_write_api_key.id}' password='${module.customer_cluster.developer_write_api_key.secret}';",

  # ${title(module.customer_cluster.developer_read_service_account.display_name)} sasl jaas config
  "sasl.jaas.config": "org.apache.kafka.common.security.plain.PlainLoginModule required username='${module.customer_cluster.developer_read_api_key.id}' password='${module.customer_cluster.developer_read_api_key.secret}';",

  # schema registry
  "schema.registry.url": "${module.staging_environment.schema_registry_cluster.rest_endpoint}",
  "basic.auth.credentials.source": "USER_INFO",
  "basic.auth.user.info": "${module.customer_cluster.data_steward_api_key.id}:${module.customer_cluster.data_steward_api_key.secret}",

  **************
  **************

  Getting Started with Flink:

  > confluent flink shell --compute-pool ${module.customer_cluster.flink_compute_pool_id} --environment ${module.staging_environment.id}

  EOT

  sensitive = true
}

output "shadowtraffic-config" {
  value = <<-EOT

  # Replace the value in `/shadowtraffic/orders/config/connections/staging-kafka.json` with the value below

  {
    "bootstrap.servers": "${module.customer_cluster.confluent_kafka_cluster.bootstrap_endpoint}",
    "sasl.jaas.config": "org.apache.kafka.common.security.plain.PlainLoginModule required username='${module.customer_cluster.developer_write_api_key.id}' password='${module.customer_cluster.developer_write_api_key.secret}';",
    "schema.registry.url": "${module.staging_environment.schema_registry_cluster.rest_endpoint}",
    "basic.auth.user.info": "${module.customer_cluster.data_steward_api_key.id}:${module.customer_cluster.data_steward_api_key.secret}",

    "key.serializer": "org.apache.kafka.common.serialization.StringSerializer",
    "value.serializer": "io.confluent.kafka.serializers.KafkaAvroSerializer",
    "basic.auth.credentials.source": "USER_INFO",
    "sasl.mechanism": "PLAIN",
    "security.protocol": "SASL_SSL",
    "client.dns.lookup": "use_all_dns_ips"
  }
  EOT

  sensitive = true
}

