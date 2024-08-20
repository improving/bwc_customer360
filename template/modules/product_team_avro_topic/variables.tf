variable "topic_name" {
  description = "The Kafka topic name"
  type        = string
}

variable "topic_configs" {
  description = "Map of Kafka Topic configurations"
  type        = map
  default = {}
}

variable "value_schema_file" {
  description = "The Avro schema file"
  type        = string
}

variable "kafka_api_key" {
  type = string
}

variable "kafka_api_secret" {
  type = string
}

variable "kafka_id" {
  type = string
}

variable "kafka_rest_endpoint" {
  type = string
}

variable "schema_registry_api_key" {
  type = string
}

variable "schema_registry_api_secret" {
  type = string
}

variable "schema_registry_id" {
  type = string
}

variable "schema_registry_rest_endpoint" {
  type = string
}



