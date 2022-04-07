#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account


 CORS
 https://docs.microsoft.com/en-us/rest/api/storageservices/Cross-Origin-Resource-Sharing--CORS--Support-for-the-Azure-Storage-Services?redirectedfrom=MSDN

 ### Module info
 ---

 * `account_kind` Changing the account_kind value from Storage to StorageV2 will not trigger a force new on the storage account, it will only upgrade the existing storage account from Storage to StorageV2 keeping the existing storage account in place.
 * `min_tls_version` At this time min_tls_version is only supported in the Public Cloud, China Cloud, and US Government Cloud.
 * `allow_nested_items_to_be_public ` At this time allow_blob_public_access (allow_nested_items_to_be_public) is only supported in the Public Cloud, China Cloud, and US Government Cloud.
 * `nfsv3_enabled` This can only be true when account_tier is Standard and account_kind is StorageV2, or account_tier is Premium and account_kind is BlockBlobStorage. Additionally, the is_hns_enabled is true, and enable_https_traffic_only is false.
 * `infrastructure_encryption_enabled` This can only be true when account_kind is StorageV2 or when account_tier is Premium and account_kind is BlockBlobStorage.
 * 
### Troubleshoot

#### Storage 

 Error: Failed to decode resource from state
│
│ Error decoding "module.storage_account.azurerm_storage_account.sa" from previous state: unsupported attribute "allow_blob_public_access"

 Error: Plugin did not respond
│
│   with data.azurerm_servicebus_namespace_authorization_rule.listen,
│   on data-2-sbus.tf line 4, in data "azurerm_servicebus_namespace_authorization_rule" "listen":
│    4: data "azurerm_servicebus_namespace_authorization_rule" "listen" {
│
│ The plugin encountered an error, and failed to respond to the plugin.(*GRPCProvider).ReadDataSource call. The plugin logs may contain more details.

