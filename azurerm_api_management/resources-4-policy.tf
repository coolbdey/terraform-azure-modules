# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy

/*
  TODO:
 Error: API "Staging MinSide API v2" Revision "1" (API Management Service "*" / Resource Group "*") does not exist!
│
│   with module.api_management.data.azurerm_api_management_api.api[6],
│   on ..\..\..\modules\azurerm_api_management\data.tf line 17, in data "azurerm_api_management_api" "api":
│   17: data "azurerm_api_management_api" "api" {
*/

resource "azurerm_api_management_api_policy" "policy" {
  depends_on = [data.azurerm_api_management_api.api]
  count      = var.import_policy_all ? length(var.apis) : 0

  api_name            = var.apis[count.index].name
  api_management_name = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  xml_content         = var.apis[count.index].policy_xml
}

