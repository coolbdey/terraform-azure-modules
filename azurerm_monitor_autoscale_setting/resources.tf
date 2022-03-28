# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting
# https://www.pmichaels.net/2021/05/08/terraform-autoscale-an-app-service/
resource "azurerm_monitor_autoscale_setting" "mas" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  target_resource_id  = var.target_resource_id

  dynamic "profile" {
    for_each = length(var.profiles) > 0 ? var.profiles : []
    iterator = each

    content {
      name = each.value.name

      capacity {
        default = each.value.capacity.default
        minimum = each.value.capacity.var.minimum
        maximum = each.value.capacity.var.maximum
      }

      dynamic "rule" {
        for_each = length(each.value.rules) > 0 ? each.value.rules : []
        iterator = eachsub

        content {
          metric_trigger {
            metric_name        = eachsub.value.metric_trigger.metric_name # asp: 'CpuPercentage', vmss: 'Percentage CPU' 
            metric_resource_id = eachsub.value.metric_trigger.target_resource_id
            time_grain         = eachsub.value.metric_trigger.time_grain       # "PT1M"
            statistic          = eachsub.value.metric_trigger.statistic        # "Average"
            time_window        = eachsub.value.metric_trigger.time_window      # "PT5M"
            time_aggregation   = eachsub.value.metric_trigger.time_aggregation # "Average"
            operator           = eachsub.value.metric_trigger.operator         # "GreaterThan"
            threshold          = eachsub.value.metric_trigger.threshold        # 75
            metric_namespace   = local.metric_namespace

            dynamic "dimensions" {
              for_each = length(eachsub.value.dimensions) > 0 ? eachsub.value.dimensions : []
              iterator = eachsubsub

              content {
                name     = eachsubsub.value.name     # "AppName"
                operator = eachsubsub.value.operator # "Equals"
                values   = eachsubsub.value.values   # ["App1"]
              }
            }
          }

          scale_action {
            cooldown  = eachsub.value.scale_action.cooldown  # "PT1M"
            direction = eachsub.value.scale_action.direction # "Increase"
            type      = eachsub.value.scale_action.type      # "ChangeCount"
            value     = eachsub.value.scale_action.value     # "1"
          }
        }
      }

      dynamic "fixed_date" {
        for_each = each.value.fixed_date.enabled ? [each.value.fixed_date] : []
        iterator = eachsub
        content {
          timezone = eachsub.value.timezone
          start    = eachsub.value.start
          end      = eachsub.value.end
        }
      }

      dynamic "recurrence" {
        for_each = each.value.recurrence.enabled ? [each.value.recurrence] : []
        iterator = eachsub
        content {
          frequency = eachsub.value.frequency
          timezone  = eachsub.value.timezone
          days      = eachsub.value.days
          hours     = eachsub.value.hours
          minutes   = eachsub.value.minutes
        }
      }
    }
  }

  notification {
    email {
      send_to_subscription_administrator    = var.notification.email.send_to_subscription_administrator
      send_to_subscription_co_administrator = var.notification.email.send_to_subscription_co_administrator
      custom_emails                         = var.notification.email.custom_emails
    }
    webhooks = var.notification.webhooks
  }

  lifecycle {
    ignore_changes = [target_resource_id, location, winrm_listener]
  }
}
