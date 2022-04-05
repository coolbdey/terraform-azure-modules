output "ids" {
  description = "The IDs of the Virtual Machine Extension"
  value       = [for item in azurerm_virtual_machine_extension.vme : item.id]
}