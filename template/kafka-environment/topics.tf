module "customers_a_topic" {
  source = "../modules/product_team_avro_topic"

  topic_name        = "demo.customers.system-a"
  value_schema_file = file("./schemas/avro/customer-a.avsc")

  kafka_id            = module.customer_cluster.confluent_kafka_cluster.id
  kafka_rest_endpoint = module.customer_cluster.confluent_kafka_cluster.rest_endpoint
  kafka_api_key       = module.customer_cluster.cluster_admin_api_key.id
  kafka_api_secret    = module.customer_cluster.cluster_admin_api_key.secret

  schema_registry_id            = module.staging_environment.schema_registry_cluster.id
  schema_registry_rest_endpoint = module.staging_environment.schema_registry_cluster.rest_endpoint
  schema_registry_api_key       = module.customer_cluster.data_steward_api_key.id
  schema_registry_api_secret    = module.customer_cluster.data_steward_api_key.secret

  depends_on = [ module.customer_cluster ]

}

module "customers_b_topic" {
  source = "../modules/product_team_avro_topic"

  topic_name        = "demo.customers.system-b"
  value_schema_file = file("./schemas/avro/customer-b.avsc")
  
  kafka_id            = module.customer_cluster.confluent_kafka_cluster.id
  kafka_rest_endpoint = module.customer_cluster.confluent_kafka_cluster.rest_endpoint
  kafka_api_key       = module.customer_cluster.cluster_admin_api_key.id
  kafka_api_secret    = module.customer_cluster.cluster_admin_api_key.secret

  schema_registry_id            = module.staging_environment.schema_registry_cluster.id
  schema_registry_rest_endpoint = module.staging_environment.schema_registry_cluster.rest_endpoint
  schema_registry_api_key       = module.customer_cluster.data_steward_api_key.id
  schema_registry_api_secret    = module.customer_cluster.data_steward_api_key.secret

  depends_on = [ module.customer_cluster ]
}

module "customers_mapping_topic" {
  source = "../modules/product_team_avro_topic"

  topic_name        = "demo.customers.id-mapping"
  value_schema_file = file("./schemas/avro/customer-mapping.avsc")

  kafka_id            = module.customer_cluster.confluent_kafka_cluster.id
  kafka_rest_endpoint = module.customer_cluster.confluent_kafka_cluster.rest_endpoint
  kafka_api_key       = module.customer_cluster.cluster_admin_api_key.id
  kafka_api_secret    = module.customer_cluster.cluster_admin_api_key.secret

  schema_registry_id            = module.staging_environment.schema_registry_cluster.id
  schema_registry_rest_endpoint = module.staging_environment.schema_registry_cluster.rest_endpoint
  schema_registry_api_key       = module.customer_cluster.data_steward_api_key.id
  schema_registry_api_secret    = module.customer_cluster.data_steward_api_key.secret

  depends_on = [ module.customer_cluster ]
}

module "customers_golden_topic" {
  source = "../modules/product_team_avro_topic"

  topic_name        = "demo.customers.golden"
  value_schema_file = file("./schemas/avro/customer-golden.avsc")

  kafka_id            = module.customer_cluster.confluent_kafka_cluster.id
  kafka_rest_endpoint = module.customer_cluster.confluent_kafka_cluster.rest_endpoint
  kafka_api_key       = module.customer_cluster.cluster_admin_api_key.id
  kafka_api_secret    = module.customer_cluster.cluster_admin_api_key.secret

  schema_registry_id            = module.staging_environment.schema_registry_cluster.id
  schema_registry_rest_endpoint = module.staging_environment.schema_registry_cluster.rest_endpoint
  schema_registry_api_key       = module.customer_cluster.data_steward_api_key.id
  schema_registry_api_secret    = module.customer_cluster.data_steward_api_key.secret

  depends_on = [ module.customer_cluster ]
}
