/*
resource "azurerm_api_management_api" "api" {
  depends_on = [azurerm_api_management.apim]
  count      = length(var.apis)

  name                  = var.apis[count.index].name
  resource_group_name   = data.azurerm_resource_group.rg.name
  api_management_name   = azurerm_api_management.apim.name
  revision              = var.apis[count.index].revision
  display_name          = var.apis[count.index].display_name
  path                  = var.apis[count.index].path
  protocols             = var.apis[count.index].protocols
  description           = var.apis[count.index].description
  service_url           = var.apis[count.index].service_url #- (Optional) Absolute URL of the backend service implementing this API.
  subscription_required = var.apis[count.index].subscription_required
  #version               = var.apis[count.index].version
  #version_set_id        = var.apis[count.index].version_set_id

  #import {
  #  content_format = "swagger-link-json"
  #  content_value  = "http://conferenceapi.azurewebsites.net/?format=json"
 # }

  #oauth2_authorization {

  #}

  #openid_authentication {

  #}
}

*/
