output "client_id" {
  description = "The application ID (client ID) of the application associated with this service principal."
  value       = data.azuread_service_principal.sp.application_id
}

output "client_secret" {
  description = "he application ID (client Secret) of the application associated with this service principal."
  value       = azuread_service_principal_password.pass.value
}

