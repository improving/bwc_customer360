locals {
  flink_default_properties = {
    # SET TABLE 'staging';
    "sql.current-catalog"  = data.confluent_environment.this.display_name
    # SET DATABASE 'customer';
    "sql.current-database" = module.customer_cluster.confluent_kafka_cluster.display_name
  }
}