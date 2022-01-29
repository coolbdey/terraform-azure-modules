output "container_sas" {
  description = "The computed Blob Container Shared Access Signature (SAS)."
  value       = data.azurerm_storage_account_blob_container_sas.sas.sas
}

output "container_sas_url" {
  description = "The computed Blob Container Shared Access Signature (SAS)."
  value       = "https://${var.sa_name}.blob.core.windows.net/${var.name}${data.azurerm_storage_account_blob_container_sas.sas.sas}"
}