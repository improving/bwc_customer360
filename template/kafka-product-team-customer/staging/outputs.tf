output "shadowtraffic-config" {
  value = <<-EOT

  # Replace the value in `/shadowtraffic/orders/config/connections/staging-kafka.json` with the value below

  {
    "bootstrap.servers": "${module.customer_cluster.confluent_kafka_cluster.bootstrap_endpoint}",
    "sasl.jaas.config": "org.apache.kafka.common.security.plain.PlainLoginModule required username='${module.customer_cluster.developer_write_api_key.id}' password='${module.customer_cluster.developer_write_api_key.secret}';",
    "schema.registry.url": "${data.confluent_schema_registry_cluster.this.rest_endpoint}",
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

output "resource-ids" {
  value = <<-EOT
  '${data.confluent_environment.this.display_name}' Environment ID: ${data.confluent_environment.this.id}
  '${module.customer_cluster.confluent_kafka_cluster.display_name}' Cluster ID: ${module.customer_cluster.id}
  '${module.customer_cluster.confluent_kafka_cluster.display_name}' Flink Compute Pool ID: ${module.customer_cluster.flink_compute_pool_id}
  '${module.customer_cluster.confluent_kafka_cluster.display_name}' Cluster Admin: "${module.customer_cluster.cluster_admin_api_key.id}:${module.customer_cluster.cluster_admin_api_key.secret}"

  ****************************
  Metrics Scrape Job Configs
  ****************************
  Flink Scrape Job URL:   https://api.telemetry.confluent.cloud/v2/metrics/cloud/export?resource.compute_pool.id=${module.customer_cluster.flink_compute_pool_id}
  Cluster Scrape Job URL: https://api.telemetry.confluent.cloud/v2/metrics/cloud/export?resource.kafka.id=${module.customer_cluster.id}

  Metrics API Username/Password - RUN `/kafka-ops-team > terraform output staging-resource-ids`

  **************
  Client Configs
  **************

  "bootstrap.servers": "${module.customer_cluster.confluent_kafka_cluster.bootstrap_endpoint}",

  # '${module.customer_cluster.developer_write_service_account.display_name}' sasl jaas config
  "sasl.jaas.config": "org.apache.kafka.common.security.plain.PlainLoginModule required username='${module.customer_cluster.developer_write_api_key.id}' password='${module.customer_cluster.developer_write_api_key.secret}';",

  # '${module.customer_cluster.developer_read_service_account.display_name}' sasl jaas config
  "sasl.jaas.config": "org.apache.kafka.common.security.plain.PlainLoginModule required username='${module.customer_cluster.developer_read_api_key.id}' password='${module.customer_cluster.developer_read_api_key.secret}';",

  # schema registry
  "schema.registry.url": "${data.confluent_schema_registry_cluster.this.rest_endpoint}",
  "basic.auth.credentials.source": "USER_INFO",
  "basic.auth.user.info": "${module.customer_cluster.data_steward_api_key.id}:${module.customer_cluster.data_steward_api_key.secret}",

  **************
  **************

  Getting Started with Flink:

  > confluent flink shell --compute-pool ${module.customer_cluster.flink_compute_pool_id} --environment ${data.confluent_environment.this.id}

  EOT

  sensitive = true
}
