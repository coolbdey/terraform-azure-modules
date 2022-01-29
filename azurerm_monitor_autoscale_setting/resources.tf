# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting
# https://www.pmichaels.net/2021/05/08/terraform-autoscale-an-app-service/
resource "azurerm_monitor_autoscale_setting" "mas" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  target_resource_id  = var.target_resource_id

  profile {
    name = "default"

    capacity {
      default = var.capacity_min
      minimum = var.capacity_min
      maximum = var.capacity_max
    }

    rule {
      metric_trigger {
        metric_name        = local.metric_name
        metric_resource_id = var.target_resource_id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
        metric_namespace   = local.metric_namespace

        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = local.metric_name
        metric_resource_id = var.target_resource_id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
        metric_namespace   = local.metric_namespace
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }

  notification {
    email {
      send_to_subscription_administrator    = var.notification_enabled
      send_to_subscription_co_administrator = var.notification_enabled
      custom_emails                         = var.notification_emails
    }
  }

  lifecycle {
    ignore_changes = [target_resource_id, location]
  }
}
