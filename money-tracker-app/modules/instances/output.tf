output "frontend_ip" {
  value = google_compute_instance.frontend.network_interface.0.access_config.0.nat_ip
}

output "backend_ip" {
  value = google_compute_instance.backend.network_interface.0.access_config.0.nat_ip
}