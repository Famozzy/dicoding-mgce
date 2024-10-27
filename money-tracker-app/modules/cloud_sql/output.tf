output "db_password" {
  description = "The password for the database"
  sensitive   = true
  value       = sensitive(google_sql_database_instance.db_instance.root_password)
}

output "db_name" {
  description = "The name of the database"
  value       = google_sql_database.db.name
}

output "instance_ip" {
  description = "The URL of the SQL instance"
  value       = google_sql_database_instance.db_instance.ip_address.0.ip_address
}