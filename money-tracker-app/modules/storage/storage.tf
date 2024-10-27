resource "google_storage_bucket" "bucket" {
  name          = var.bucket_name
  location      = var.location
  force_destroy = true

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      age                = 30
      num_newer_versions = 5
    }
  }
}

resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.bucket.name
  role   = "READER"
  entity = "allUsers"
}
