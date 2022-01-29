# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/servicebus_namespace
output "location" {
  value = data.azurerm_servicebus_namespace.sbns.location
}

output "id" {
  value = data.azurerm_servicebus_namespace.sbns.id
}

# The following attributes are exported only if there is an authorization rule named RootManageSharedAccessKey which is created automatically by Azure.
####### 

output "default_primary_connection_string" {
  value = data.azurerm_servicebus_namespace.sbns.default_primary_connection_string
}

output "default_primary_key" {
  value = data.azurerm_servicebus_namespace.sbns.default_primary_key
}

output "topic_id" {
  value = azurerm_servicebus_topic.topic.*.id
}

output "queue_id" {
  value = azurerm_servicebus_queue.queue.*.id
}
