# Setup for an Avro based topic
resource "google_bigquery_table" "table_with_avro_schema" {
  deletion_protection = false
  table_id            = "table_with_avro_schema"
  dataset_id          = google_bigquery_dataset.dataset.dataset_id
  schema              = file(local.table_avro_schema_path)
}

resource "google_pubsub_schema" "avro_schema" {
  name       = "proto_schema"
  type       = "AVRO"
  definition = file(local.avro_schema_path)
}

resource "google_pubsub_topic" "topic_with_avro_schema" {
  name       = "topic_with_avro_schema"
  depends_on = [google_pubsub_schema.avro_schema]
  schema_settings {
    schema   = google_pubsub_schema.avro_schema.id
    encoding = "JSON"
  }
}

resource "google_pubsub_subscription" "sub_with_avro_schema" {
  name  = "sub_with_avro_schema"
  topic = google_pubsub_topic.topic_with_avro_schema.name


  bigquery_config {
    table            = "${var.project_id}.${google_bigquery_table.table_with_avro_schema.dataset_id}.${google_bigquery_table.table_with_avro_schema.table_id}"
    use_topic_schema = true
    write_metadata   = true
  }

  depends_on = [google_project_iam_member.viewer, google_project_iam_member.editor]
}