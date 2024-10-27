resource "google_sql_database_instance" "db_instance" {
  name                = "mt-sql-instance"
  database_version    = "MYSQL_5_7"
  region              = var.region
  root_password       = "password" # don't try this at production
  deletion_protection = false

  settings {
    tier      = "db-f1-micro"
    disk_size = 10

    ip_configuration {
      ipv4_enabled = true

      authorized_networks {
        name  = "public"
        value = "0.0.0.0/0"
      }
    }
  }
}

resource "google_sql_database" "db" {
  name     = "mt_db"
  instance = google_sql_database_instance.db_instance.name
}
