terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.83.0"
    }
  }
}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

data "confluent_organization" "this" {}

// the pre-provisioned environment (we won't use this)
data "confluent_environment" "default" {
  display_name = "default"
}

module "staging_environment" {
  source = "../modules/confluent_cloud_environment"

  environment_display_name  = "staging"
  stream_governance_package = "ESSENTIALS"

  providers = {
    confluent = confluent
  }
}

module "customer_cluster" {
  source = "../modules/product_team_standard_cluster"

  cluster_display_name   = "customer"
  environment_id         = module.staging_environment.id
  enable_flink_workspace = true

  providers = {
    confluent = confluent
  }

  depends_on = [ module.staging_environment ]
}
