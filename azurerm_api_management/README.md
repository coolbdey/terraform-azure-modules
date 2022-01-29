

* https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples/api-management


Deploy time: 10 minutes


│ Error: creating/updating API Management Service "*" (Resource Group "*"): apimanagement.ServiceClient#CreateOrUpdate: Failure sending request: StatusCode=0 -- Original Error: autorest/azure: Service returned an error. Status=<nil> Code="ServiceAlreadyExistsInSoftDeletedState" Message="Api service * was soft-deleted. In order to create the new service with the same name, you have to either undelete the service or purge it. See https://aka.ms/apimsoftdelete."
│

DELETE

```powershell

$Url = "https://management.azure.com/subscriptions/737d1266-ccb9-492e-bef4-ee72fed55f23/providers/Microsoft.ApiManagement/locations/norwayeast/deletedservices/*?api-version=2020-06-01-preview"


Invoke-WebRequest -Method Delete -Uri $Url -UseDefaultCredentials




# 59 minute to deploy
module.api_management.azurerm_api_management.apim: Still creating... [49m12s elapsed]

```