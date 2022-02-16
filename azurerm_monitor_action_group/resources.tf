# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group
resource "azurerm_monitor_action_group" "mag" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  short_name          = var.short_name

  dynamic "automation_runbook_receiver" {
    for_each = length(var.automation_runbook_receiver) > 0 ? var.automation_runbook_receiver : []
    iterator = each
    content {
      name                    = each.value.name
      automation_account_id   = each.value.automation_account_id
      runbook_name            = each.value.runbook_name
      webhook_resource_id     = each.value.webhook_resource_id
      is_global_runbook       = each.value.is_global_runbook #true
      service_uri             = each.value.service_uri
      use_common_alert_schema = each.value.use_common_alert_schema #true
    }
  }

  dynamic "azure_app_push_receiver" {
    for_each = length(var.azure_app_push_receiver) > 0 ? var.azure_app_push_receiver : []
    iterator = each
    content {
      name          = each.value.name
      email_address = each.value.email_address
    }
  }

  dynamic "azure_function_receiver" {
    for_each = length(var.azure_function_receiver) > 0 ? var.azure_function_receiver : []
    iterator = each
    content {
      name                     = each.value.name
      function_app_resource_id = each.value.function_app_resource_id
      function_name            = each.value.function_name
      http_trigger_url         = each.value.http_trigger_url
      use_common_alert_schema  = each.value.use_common_alert_schema #true
    }
  }

  dynamic "email_receiver" {
    for_each = length(var.email_receiver) > 0 ? var.email_receiver : []
    iterator = each
    content {
      name                    = each.value.name
      email_address           = each.value.email_address
      use_common_alert_schema = each.value.use_common_alert_schema
    }
  }

  dynamic "event_hub_receiver" {
    for_each = length(var.event_hub_receiver) > 0 ? var.event_hub_receiver : []
    iterator = each
    content {
      name                    = each.value.name
      event_hub_id            = each.value.event_hub_id
      use_common_alert_schema = each.value.use_common_alert_schema
    }
  }

  dynamic "itsm_receiver" {
    for_each = length(var.itsm_receiver) > 0 ? var.itsm_receiver : []
    iterator = each
    content {
      name                 = each.value.name
      workspace_id         = each.value.workspace_id
      connection_id        = each.value.connection_id
      ticket_configuration = "{}"
      region               = each.value.region
    }
  }

  dynamic "logic_app_receiver" {
    for_each = length(var.logic_app_receiver) > 0 ? var.logic_app_receiver : []
    iterator = each
    content {
      name                    = each.value.name
      resource_id             = each.value.resource_id
      callback_url            = each.value.callback_url
      use_common_alert_schema = each.value.use_common_alert_schema
    }
  }

  dynamic "sms_receiver" {
    for_each = length(var.sms_receiver) > 0 ? var.sms_receiver : []
    iterator = each
    content {
      name         = each.value.name
      country_code = each.value.country_code
      phone_number = each.value.phone_number
    }
  }

  dynamic "voice_receiver" {
    for_each = length(var.voice_receiver) > 0 ? var.voice_receiver : []
    iterator = each
    content {
      name         = each.value.name
      country_code = each.value.country_code
      phone_number = each.value.phone_number
    }
  }

  dynamic "webhook_receiver" {
    for_each = length(var.webhook_receiver) > 0 ? var.webhook_receiver : []
    iterator = each
    content {
      name                    = each.value.name
      service_uri             = each.value.service_uri
      use_common_alert_schema = each.value.use_common_alert_schema
    }
  }

  tags = var.tags
}