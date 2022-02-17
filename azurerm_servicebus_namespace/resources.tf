
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace
resource "azurerm_servicebus_namespace" "sbns" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = var.sku
  capacity            = var.capacity

  tags = var.tags

  lifecycle {
    ignore_changes = [tags["updated_date"], location] # IMPORTANT! Do do remove 'location' or else Terraform will want todo a forces replacement on the service bus 
  }
}

###########################################################
####### SERVICE BUS TOPICS

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic
resource "azurerm_servicebus_topic" "topic" {
  depends_on = [azurerm_servicebus_namespace.sbns]
  count      = length(var.topics)

  name = var.topics[count.index].name
  #resource_group_name = data.azurerm_resource_group.rg.name  # Deprecated
  namespace_id = azurerm_servicebus_namespace.sbns.id
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription
resource "azurerm_servicebus_subscription" "sub" {
  depends_on = [azurerm_servicebus_topic.topic]
  count      = length(var.topics)

  name = var.topics[count.index].subscriptions[0].name # TODO
  #resource_group_name = data.azurerm_resource_group.rg.name
  topic_id = azurerm_servicebus_topic.topic[count.index].id
  #namespace_name     = azurerm_servicebus_namespace.sbns.name
  #topic_name         = var.topics[count.index].name
  max_delivery_count = var.topics[count.index].subscriptions[0].max_count # TODO 
}


###########################################################
####### SERVICE BUS QUEUES

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_queue
resource "azurerm_servicebus_queue" "queue" {
  depends_on = [azurerm_servicebus_namespace.sbns]
  count      = length(var.queues)

  name = var.queues[count.index].name
  #namespace_id
  resource_group_name   = data.azurerm_resource_group.rg.name
  namespace_name        = azurerm_servicebus_namespace.sbns.name
  lock_duration         = "PT1M" #  (Optional) The ISO 8601 timespan duration of a peek-lock; that is, the amount of time that the message is locked for other receivers. Maximum value is 5 minutes. Defaults to 1 minute (PT1M).
  max_size_in_megabytes = 1024   # (Optional) Integer value which controls the size of memory allocated for the queue. For supported values see the "Queue or topic size" section of Service Bus Quotas. Defaults to 1024
  #forward_to # (Optional) The name of a Queue or Topic to automatically forward messages to. Please see the documentation for more information.
  # forward_dead_lettered_messages_to - (Optional) The name of a Queue or Topic to automatically forward dead lettered messages to.
}

###########################################################
####### ACCESS RULES

resource "azurerm_servicebus_namespace_authorization_rule" "rule_listen" {
  name                = "Listen"
  namespace_name      = azurerm_servicebus_namespace.sbns.name
  resource_group_name = data.azurerm_resource_group.rg.name

  listen = true
  send   = false
  manage = false
}
resource "azurerm_servicebus_namespace_authorization_rule" "rule_send" {
  name                = "Send"
  namespace_name      = azurerm_servicebus_namespace.sbns.name
  resource_group_name = data.azurerm_resource_group.rg.name

  listen = false
  send   = true
  manage = false
}
resource "azurerm_servicebus_queue_authorization_rule" "rule_listen" {
  depends_on = [azurerm_servicebus_queue.queue]
  count      = length(var.queues)

  name     = "Listen"
  queue_id = azurerm_servicebus_queue.queue[count.index].id
  #namespace_name      = azurerm_servicebus_namespace.sbns.name
  #queue_name          = var.queues[count.index].name
  #resource_group_name = data.azurerm_resource_group.rg.name
  listen = var.queues[count.index].rule_manage ? true : var.queues[count.index].rule_listen
  send   = false
  manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "rule_send" {
  depends_on = [azurerm_servicebus_queue.queue]
  count      = length(var.queues)

  name     = "Send"
  queue_id = azurerm_servicebus_queue.queue[count.index].id
  #namespace_name      = azurerm_servicebus_namespace.sbns.name
  #queue_name          = var.queues[count.index].name
  #resource_group_name = data.azurerm_resource_group.rg.name
  send   = var.queues[count.index].rule_manage ? true : var.queues[count.index].rule_send
  listen = false
  manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "rule_manage" {
  depends_on = [azurerm_servicebus_queue.queue]
  count      = length(var.queues)

  name     = "Manage"
  queue_id = azurerm_servicebus_queue.queue[count.index].id
  #namespace_name      = azurerm_servicebus_namespace.sbns.name
  #queue_name          = var.queues[count.index].name
  #resource_group_name = data.azurerm_resource_group.rg.name

  manage = var.queues[count.index].rule_manage
  listen = var.queues[count.index].rule_manage ? true : true # Error: One of the `listen`, `send` or `manage` properties needs to be set
  send   = var.queues[count.index].rule_manage ? true : false
}

///////////////////////////////////////////////////////////////////////
//////////// RBAC
resource "azurerm_role_assignment" "sbns_role" {
  depends_on = [azurerm_servicebus_namespace.sbns]
  count      = var.enable_rbac_authorization ? length(var.rbac_roles) : 0

  scope                = azurerm_servicebus_namespace.sbns.id
  role_definition_name = var.rbac_roles[count.index].role_definition_name
  principal_id         = var.rbac_roles[count.index].principal_id
}
