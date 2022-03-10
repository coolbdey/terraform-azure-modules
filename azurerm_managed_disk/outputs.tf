output "id" {
  description = "The ID of the Managed Disk."
  value       = azurerm_managed_disk.md.id
}

output "max_shares" {
  value = var.max_shares
}