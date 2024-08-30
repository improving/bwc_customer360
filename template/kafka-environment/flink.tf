resource "confluent_flink_statement" "random_int_table" {
  organization {
    id = data.confluent_organization.this.id
  }
  environment {
    id = module.staging_environment.id
  }
  compute_pool {
    id = module.customer_cluster.flink_compute_pool_id
  }
  principal {
    id = module.customer_cluster.developer_write_service_account.id
  }
  statement  = file("./flink-statements/create-combined-customer-record.sql")
  statement_name = "create-customer-golden-record"

  properties = {
    # SET TABLE 'staging';
    "sql.current-catalog"  = module.staging_environment.confluent_environment.display_name
    # SET DATABASE 'inventory';
    "sql.current-database" = module.customer_cluster.confluent_kafka_cluster.display_name
  }

  rest_endpoint = module.customer_cluster.flink_rest_endpoint
  credentials {
    key    = module.customer_cluster.flink_admin_api_key.id
    secret = module.customer_cluster.flink_admin_api_key.secret
  }

  depends_on = [ 
    module.customers_a_topic,
    module.customers_b_topic,
    module.customers_mapping_topic,
    module.customers_golden_topic 
  ]
}