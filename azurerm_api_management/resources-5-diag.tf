# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_diagnostic
resource "azurerm_api_management_logger" "logger" {
  depends_on = [azurerm_api_management.apim, data.azurerm_application_insights.appi]

  name                = var.logger_name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg.name

  application_insights {
    instrumentation_key = data.azurerm_application_insights.appi.instrumentation_key
  }
}

resource "azurerm_api_management_diagnostic" "diag" {
  depends_on = [azurerm_api_management_logger.logger]

  identifier               = var.diag_identifier
  resource_group_name      = data.azurerm_resource_group.rg.name
  api_management_name      = azurerm_api_management.apim.name
  api_management_logger_id = azurerm_api_management_logger.logger.id

  sampling_percentage       = 5.0
  always_log_errors         = true
  log_client_ip             = true
  verbosity                 = "verbose"
  http_correlation_protocol = "W3C"

  frontend_request {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "accept",
      "origin",
    ]
  }

  frontend_response {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "content-length",
      "origin",
    ]
  }

  backend_request {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "accept",
      "origin",
    ]
  }

  backend_response {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "content-length",
      "origin",
    ]
  }
}

resource "azurerm_api_management_api_diagnostic" "diag" {
  depends_on = [azurerm_api_management_logger.logger]
  count      = length(var.apis)

  identifier               = var.diag_identifier
  resource_group_name      = data.azurerm_resource_group.rg.name
  api_management_name      = azurerm_api_management.apim.name
  api_name                 = var.apis[count.index].name
  api_management_logger_id = azurerm_api_management_logger.logger.id

  sampling_percentage       = 5.0
  always_log_errors         = true
  log_client_ip             = true
  verbosity                 = "verbose"
  http_correlation_protocol = "W3C"

  frontend_request {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "accept",
      "origin",
    ]
  }

  frontend_response {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "content-length",
      "origin",
    ]
  }

  backend_request {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "accept",
      "origin",
    ]
  }

  backend_response {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "content-length",
      "origin",
    ]
  }
}