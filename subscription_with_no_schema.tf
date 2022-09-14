# Setup for a topic with no schema

resource "google_bigquery_table" "table_with_no_schema" {
  deletion_protection = false
  table_id            = "table_with_no_schema"
  dataset_id          = google_bigquery_dataset.dataset.dataset_id
}

resource "google_pubsub_topic" "topic_with_no_schema" {
  name = "topic_with_no_schema"
}

resource "google_pubsub_subscription" "sub_with_no_schema" {
  name       = "sub_with_no_schema"
  topic      = "topic_with_no_schema"
  depends_on = [google_project_iam_member.viewer, google_project_iam_member.editor]
}
