output "id" {
  description = "The Key Vault Certificate ID."
  value       = azurerm_key_vault_certificate.cert.id
}
output "thumbprint" {
  description = "The X509 Thumbprint of the Key Vault Certificate represented as a hexadecimal string."
  value       = azurerm_key_vault_certificate.cert.thumbprint
}
output "secret_id" {
  description = "The ID of the associated Key Vault Secret.value"
  value       = azurerm_key_vault_certificate.cert.secret_id
}

output "certificate_data_base64" {
  description = "The Base64 encoded Key Vault Certificate data."
  value       = azurerm_key_vault_certificate.cert.certificate_data_base64
}

