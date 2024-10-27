resource "google_project_iam_member" "reviewer" {
  # for_each = toset(["roles/cloudsql.viewer", "roles/storage.objectViewer", "roles/viewer"])
  for_each = toset(["roles/viewer"])

  project = var.project_id
  member  = "group:reviewer_googlecloud@dicoding.com"
  role    = each.key
}

resource "google_service_account" "gcs_service_account" {
  account_id   = "gcs-sa"
  display_name = "GCS Service Account"
}

resource "google_project_iam_member" "gcs_service_account" {
  project = var.project_id
  role    = "roles/storage.objectUser"
  member  = "serviceAccount:${google_service_account.gcs_service_account.email}"
}
