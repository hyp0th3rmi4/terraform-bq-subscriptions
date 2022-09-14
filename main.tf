locals {
  proto_schema_path       = "./schemas/schema.proto"
  avro_schema_path        = "./schemas/schema.avro"
  table_proto_schema_path = "./schemas/bq_proto_schema.json"
  table_avro_schema_path  = "./schemas/bq_avro_schema.json"
}


data "google_project" "project" {

}


# General IAM for writing and reading from/to topics/tables

resource "google_project_iam_member" "viewer" {
  project = var.project_id
  role    = "roles/bigquery.metadataViewer"
  member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "editor" {
  project = data.google_project.project.project_id
  role    = "roles/bigquery.dataEditor"
  member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

# Dataset 

resource "google_bigquery_dataset" "dataset" {
  dataset_id = "subscriptions_dataset"
}







