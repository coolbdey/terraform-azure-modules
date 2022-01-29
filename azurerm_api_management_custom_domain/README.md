
Note
odule.api_management_domain[0].azurerm_api_management_custom_domain.domain: Still creating... [29m52s elapsed]
 
Elapsed time: 
module.api_management_domain[0].azurerm_api_management_custom_domain.domain: Still creating... [14m1s elapsed]

### troubleshoot
---


#### Problem System Assigned

**problem**

Error: creating/updating Custom Domain (API Management "*" / Resource Group "*"): apimanagement.ServiceClient#CreateOrUpdate: Failure sending request: StatusCode=400 -- Original Error: Code="InvalidOperation" Message="Managed Service Identity (http://aka.ms/apimmsi) type: System Assigned which is required to access KeyVault https://*.vault.azure.net/secrets/services-domain-com-self/4c0a6823e5644f0ab41657d81c2cdfaa is not enabled on the API Management service."

**Solution**

Activate identity in azurerm_api_management.apim

#### 

**Problem**

Error: creating/updating Custom Domain (API Management "*" / Resource Group "*"): apimanagement.ServiceClient#CreateOrUpdate: Failure sending request: StatusCode=400 -- Original Error: Code="InvalidOperation" Message="Failed to access KeyVault Secret https://*.vault.azure.net/secrets/services-domain-com-self/6bff2d9ed76b43d6932f6af738a7a74a using Managed Service Identity (http://aka.ms/apimmsi) of Api Management service. Check if Managed Identity of Type: SystemAssigned, ClientId: fc7551ef-0bb3-4799-97a6-f045659aa5f9 and ObjectId: cb06907c-530d-40ab-ba17-ac6f64d4d9c8 has GET permissions on secrets in the KeyVault Access Policies."
│

**Solution**

Add RBAC "Key Vault Administrator" for APIM System Assigned identity