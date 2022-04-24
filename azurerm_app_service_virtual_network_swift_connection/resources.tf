# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_virtual_network_swift_connection
resource "azurerm_app_service_virtual_network_swift_connection" "asvnsc_wa" {
  depends_on = [data.azurerm_app_service.wa, data.azurerm_subnet.asvnsc_snet]
  count      = length(var.asvnsc_apps_wa)

  app_service_id = data.azurerm_app_service.wa[count.index].id #  (Required) The ID of the App Service or Function App to associate to the VNet. Changing this forces a new resource to be created.
  subnet_id      = data.azurerm_subnet.asvnsc_snet.id          #  (Required) The ID of the subnet the app service will be associated to (the subnet must have a service_delegation configured for Microsoft.Web/serverFarms).

  lifecycle {
    ignore_changes = [app_service_id]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "asvnsc_fa" {
  depends_on = [data.azurerm_app_service.wa, data.azurerm_subnet.asvnsc_snet]
  count      = length(var.asvnsc_apps_fa)

  app_service_id = data.azurerm_function_app.fa[count.index].id #  (Required) The ID of the App Service or Function App to associate to the VNet. Changing this forces a new resource to be created.
  subnet_id      = data.azurerm_subnet.asvnsc_snet.id           #  (Required) The ID of the subnet the app service will be associated to (the subnet must have a service_delegation configured for Microsoft.Web/serverFarms).

  lifecycle {
    ignore_changes = [app_service_id]
  }


}

resource "azurerm_mssql_virtual_network_rule" "mssqlvn_sql" {
  depends_on = [data.azurerm_mssql_server.sql, data.azurerm_subnet.mssqlvn_snet]
  count      = length(var.mssqlvn_rules)

  name      = var.mssqlvn_rules[count.index].rule_name
  server_id = data.azurerm_mssql_server.sql[count.index].id
  subnet_id = data.azurerm_subnet.mssqlvn_snet[0].id

  lifecycle {
    ignore_changes = [server_id]
  }
}

resource "null_resource" "route_all_wa" {
  depends_on = [azurerm_app_service_virtual_network_swift_connection.asvnsc_wa]
  count      = length(var.asvnsc_apps_wa)

  triggers = {
    // always execute
    uuid_trigger = md5(var.asvnsc_apps_wa[count.index].name)
  }
  provisioner "local-exec" {
    when        = create
    command     = <<EOF
      "az webapp config set --resource-group ${var.asvnsc_apps_wa[count.index].rg_name} --name ${var.asvnsc_apps_wa[count.index].name} --generic-configurations '{\"vnetRouteAllEnabled\": true}'"
    EOF
    interpreter = local.interpreter
    working_dir = path.module
    on_failure  = continue
  }
}

resource "null_resource" "route_all_fa" {
  depends_on = [azurerm_app_service_virtual_network_swift_connection.asvnsc_fa]
  count      = length(var.asvnsc_apps_fa)

  triggers = {
    // always execute
    uuid_trigger = md5(var.asvnsc_apps_fa[count.index].name)
  }
  provisioner "local-exec" {
    when        = create
    command     = <<EOF
      "az functionapp config set --resource-group ${var.asvnsc_apps_fa[count.index].rg_name} --name ${var.asvnsc_apps_fa[count.index].name} --generic-configurations '{\"vnetRouteAllEnabled\": true}'"
    EOF
    interpreter = local.interpreter
    working_dir = path.module
    on_failure  = continue
  }
}
