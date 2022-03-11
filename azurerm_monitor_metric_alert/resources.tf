# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert
resource "azurerm_monitor_metric_alert" "mma" {
  depends_on = [data.azurerm_resource_group.rg]

  name                 = var.name
  resource_group_name  = data.azurerm_resource_group.rg.name
  scopes               = var.scopes
  description          = var.description
  enabled              = var.enabled
  auto_mitigate        = var.auto_mitigate
  frequency            = var.frequency
  severity             = var.severity
  target_resource_type = var.target_resource_type

  # Note:
  ## One of either criteria, dynamic_criteria or application_insights_web_test_location_availability_criteria must be specified.
  ## criteria is one or more blocks, where as dynamic_criteria and application_insights_web_test_location_availability_criteria are one block

  dynamic "criteria" {
    for_each = length(var.criterias) > 0 ? var.criterias : []
    iterator = each
    content {
      metric_namespace = each.value.metric_namespace
      metric_name      = each.value.metric_name
      aggregation      = each.value.aggregation
      operator         = each.value.operator
      threshold        = each.value.threshold
      dynamic "dimension" {
        for_each = length(each.value.dimension) > 0 ? each.value.dimension : []
        iterator = subeach
        content {
          name     = subeach.value.name
          operator = subeach.value.operator
          values   = subeach.value.values
        }
      }
    }
  }

  dynamic "dynamic_criteria" {
    for_each = length(var.dynamic_criterias) == 1 ? var.dynamic_criterias : [] # only one block
    iterator = each
    content {
      metric_namespace         = each.value.metric_namespace
      metric_name              = each.value.metric_name
      operator                 = each.value.operator
      aggregation              = each.value.aggregation
      alert_sensitivity        = each.value.alert_sensitivity
      evaluation_total_count   = each.value.evaluation_total_count
      evaluation_failure_count = each.value.evaluation_failure_count
      ignore_data_before       = each.value.ignore_data_before
      skip_metric_validation   = each.value.skip_metric_validation

      dynamic "dimension" {
        for_each = length(each.value.dimension) > 0 ? each.value.dimension : []
        iterator = subeach
        content {
          name     = subeach.value.name
          operator = subeach.value.operator
          values   = subeach.value.values
        }
      }
    }
  }

  dynamic "application_insights_web_test_location_availability_criteria" {
    for_each = length(var.aiwtla_criterias) == 1 ? var.aiwtla_criterias : [] # only one block
    iterator = each
    content {
      web_test_id           = each.value.web_test_id
      component_id          = each.value.component_id
      failed_location_count = each.value.failed_location_count
    }
  }

  dynamic "action" {
    for_each = length(var.actions) > 0 ? var.actions : []
    iterator = each
    content {
      action_group_id    = each.value.action_group_id
      webhook_properties = each.value.webhook_properties
    }
  }

  lifecycle {
    ignore_changes = [tags,name]
  }
}