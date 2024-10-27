output "bucket_name" {
  value = module.storage.bucket_name
}

# output "db_name" {
#   value = module.cloud_sql.db_name
# }

# output "db_root_password" {
#   sensitive = true
#   value     = sensitive(module.cloud_sql.db_password)
# }

# output "db_instance_ip" {
#   value = module.cloud_sql.instance_ip
# }

output "be_instance_ip" {
  value = module.instances.backend_ip
}

output "fe_instance_ip" {
  value = module.instances.frontend_ip
}