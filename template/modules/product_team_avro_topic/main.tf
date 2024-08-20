terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.83.0"
    }
  }
}

resource "confluent_kafka_topic" "topic" {
  topic_name = var.topic_name
  config = var.topic_configs

  rest_endpoint = var.kafka_rest_endpoint

  kafka_cluster {
    id = var.kafka_id
  }

  credentials {
    key = var.kafka_api_key
    secret = var.kafka_api_secret
  }
}

resource "confluent_schema" "value_schema" {
  subject_name = "${var.topic_name}-value"
  format       = "AVRO"
  schema       = var.value_schema_file

  rest_endpoint = var.schema_registry_rest_endpoint

  schema_registry_cluster {
    id = var.schema_registry_id
  }

  credentials {
    key = var.schema_registry_api_key
    secret = var.schema_registry_api_secret
  }


}