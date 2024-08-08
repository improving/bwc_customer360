terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.80.0"
    }
  }
}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

data "confluent_organization" "this" {}

// import a reference to the target environment
data "confluent_environment" "this" {
  display_name = "staging"
}

data "confluent_schema_registry_cluster" "this" {
  environment {
    id = data.confluent_environment.this.id
  }
}

// confluent_kafka_cluster
module "customer_cluster" {
  source = "../../modules/product_team_standard_cluster"

  cluster_display_name   = "customer"
  environment_id         = data.confluent_environment.this.id
  enable_flink_workspace = true

  providers = {
    confluent = confluent
  }
}

/*********************
*  CLUSTER PROVIDER  *
**********************/

// setup provider linked to the 'customer' cluster to simplify resource creation within cluster
//provider "confluent" {
//  alias = "customer_cluster"
//
//  organization_id       = data.confluent_organization.this.id
//  environment_id        = data.confluent_environment.this.id
//
//  kafka_id            = module.customer_cluster.confluent_kafka_cluster.id
//  kafka_rest_endpoint = module.customer_cluster.confluent_kafka_cluster.rest_endpoint
//  kafka_api_key       = module.customer_cluster.cluster_admin_api_key.id
//  kafka_api_secret    = module.customer_cluster.cluster_admin_api_key.secret
//
//  schema_registry_id            = data.confluent_schema_registry_cluster.this.id
//  schema_registry_rest_endpoint = data.confluent_schema_registry_cluster.this.rest_endpoint
//  schema_registry_api_key       = module.customer_cluster.data_steward_api_key.id
//  schema_registry_api_secret    = module.customer_cluster.data_steward_api_key.secret
//
//  flink_compute_pool_id = module.customer_cluster.flink_compute_pool_id
//  flink_rest_endpoint   = module.customer_cluster.flink_rest_endpoint
//  # statements managed with the 'flink admin' service account
//  flink_api_key         = module.customer_cluster.flink_admin_api_key.id
//  flink_api_secret      = module.customer_cluster.flink_admin_api_key.secret
//  # statements run with the cluster level 'developer write' service account
//  flink_principal_id    = module.customer_cluster.developer_write_service_account.id
//}

/********************
* CLUSTER RESOURCES *
*********************/

//module "customers_a_topic" {
//  source = "../../modules/product_team_avro_topic"
//
//  topic_name        = "shadowtraffic.customers.system-a"
//  value_schema_file = file("./schemas/avro/customer-a.avsc")
//
//  providers = {
//    confluent = confluent.customer_cluster
//  }
//}
//
//module "customers_b_topic" {
//  source = "../../modules/product_team_avro_topic"
//
//  topic_name        = "shadowtraffic.customers.system-b"
//  value_schema_file = file("./schemas/avro/customer-b.avsc")
//
//  providers = {
//    confluent = confluent.customer_cluster
//  }
//}
//
//module "customers_mapping_topic" {
//  source = "../../modules/product_team_avro_topic"
//
//  topic_name        = "shadowtraffic.customers.id-mapping"
//  value_schema_file = file("./schemas/avro/customer-mapping.avsc")
//
//  providers = {
//    confluent = confluent.customer_cluster
//  }
//}
//
//// sink for FlinkSQL Join of Customer A & Customer B via Customer Mapping
//module "customers_golden_topic" {
//  source = "../../modules/product_team_avro_topic"
//
//  topic_name        = "shadowtraffic.customers.golden"
//  value_schema_file = file("./schemas/avro/customer-golden.avsc")
//
//  providers = {
//    confluent = confluent.customer_cluster
//  }
//}

//resource "confluent_flink_statement" "customer_order_join" {
//  statement  = file("./flink-statements/customer-mapping-join.sql")
//
//  statement_name = "customer-order-item-customer-join"
//
//  properties = local.flink_default_properties
//
//  depends_on = [
//    # source
//    module.customers_a_topic,
//    module.customers_b_topic,
//    module.customers_mapping_topic,
//
//    # sink
//    module.customers_golden_topic
//  ]
//
//  provider = confluent.customer_cluster
//}
