locals {
  target_types = {
    "app_service_plan" = {
      metric_name      = "CpuPercentage"
      metric_namespace = "Microsoft.Web/serverfarms"
    }
    "virtual_machine_scale_set" = {
      metric_name      = "Percentage CPU"
      metric_namespace = "Microsoft.Compute/virtualMachineScaleSets"
    }
  }
  #metric_name      = local.target_types[var.target_types].metric_name
  is_vmss          = can(regex("virtualMachineScaleSets", var.target_resource_id))
  metric_namespace = local.is_vmss ? "Microsoft.Compute/virtualMachineScaleSets" : "Microsoft.Web/serverfarms" # (Optional) The namespace of the metric that defines what the rule monitors, such as microsoft.compute/virtualmachinescalesets for Virtual Machine Scale Sets.
}
