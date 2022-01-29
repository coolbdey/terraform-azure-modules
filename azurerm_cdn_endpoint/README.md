
### Troubleshoot
---

#### Request cannot be served

**Problem**

https://endpointname.azureedge.net > Request cannot be served.

Microsoft seem do have  

**Cause**

Azurerm SDK doesn't had any support for choosing Origin Type. This can only be changed from the Azure portal
The default cofiguration "custom" origin" generates this error 

**Solution**

Change the CDN Endpoint > Origin > origin-0 > Origin Type: Storage, and choose the storage account 

#### Stagin: apply: Custom domain for Staging 

**Problem**


│ Error: deleting "Custom Domain: (Name \"subname-domain-com\" / Endpoint Name \"endpointname\" / Profile Name \"cdnname\" / Resource Group \"resourcegroupname\")": cdn.CustomDomainsClient#Delete: Failure sending request: StatusCode=0 -- Original Error: autorest/azure: Service returned an error. Status=<nil> Code="Conflict" Message="Cannot delete custom domain \"subname.domain.com\" because it is still directly or indirectly (using \"cdnverify\" prefix) CNAMEd to CDN endpoint \"endpointname.azureedge.net\". Please remove the DNS CNAME record and try again."
│
│

**Solution**

1. Remove DNS CNAME records subname.domain.com
2. Comment lifecycle in module azurerm_cdn_endpoint_custom_domain.domain
3. run Terraform plan and apply
4. Enable HTTPS on the custom_domain from the Portal 