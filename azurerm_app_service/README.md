
│ Error: updating Storage Accounts for App Service "*": web.AppsClient#UpdateAzureStorageAccounts: Failure sending request: StatusCode=409 -- Original Error: autorest/azure: Service returned an error. Status=<nil> <nil>      
│
│   with module.app_service_signicat.azurerm_app_service.as,
│   on ..\..\..\modules\azurerm_app_service\resources.tf line 11, in resource "azurerm_app_service" "as":
│   11: resource "azurerm_app_service" "as" {

    
activate this service.

    https://social.msdn.microsoft.com/Forums/azure/en-US/454d64c5-4e30-48dc-b205-2e51bf72b56c/why-api-management-service-take-too-long-to-get-activated?forum=azureapimgmt