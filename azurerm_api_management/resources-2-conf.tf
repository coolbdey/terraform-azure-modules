resource "azurerm_api_management_product" "product" {
  depends_on = [azurerm_api_management.apim]
  count      = length(var.products)

  product_id            = var.products[count.index].id # (Required) The Identifier for this Product, which must be unique within the API Management Service. Changing this forces a new resource to be created.
  api_management_name   = azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.rg.name
  display_name          = var.products[count.index].display_name
  subscription_required = var.products[count.index].subscription_required # Note: approval_required can only be set when subscription_required is set to true.
  approval_required     = var.products[count.index].approval_required     # (Optional) Do subscribers need to be approved prior to being able to use the Product?
  published             = var.products[count.index].published
  description           = var.products[count.index].description

  # subscriptions_limit - (Optional) The number of subscriptions a user can have to this Product at the same time.
  # subscriptions_limit can only be set when subscription_required is set to true.
}

resource "azurerm_api_management_backend" "backend" {
  depends_on = [azurerm_api_management.apim]
  count      = length(var.backends)

  name                = var.backends[count.index].name
  resource_group_name = data.azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  protocol            = var.backends[count.index].protocol == null ? "http" : var.protocol
  url                 = var.backends[count.index].url
  description         = var.backends[count.index].description
  title               = var.backends[count.index].title

  # resource_id - (Optional) The management URI of the backend host in an external system. 
  #              This URI can be the ARM Resource ID of Logic Apps, Function Apps or API Apps, or the management endpoint of a Service Fabric cluster.

  #credentials {
  #authorization {
  #parameter = ""
  #scheme = ""
  #}

  #}
  #tls {
  #validate_certificate_chain = "" #  (Optional) Flag indicating whether SSL certificate chain validation should be done when using self-signed certificates for the backend host.
  #validate_certificate_name = "" # (Optional) Flag indicating whether SSL certificate name validation should be done when using self-signed certificates for the backend host.
  #}
}


resource "azurerm_api_management_named_value" "named" {
  depends_on = [azurerm_api_management.apim]
  count      = length(var.named_values)

  name                = var.named_values[count.index].name
  resource_group_name = data.azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  display_name        = var.named_values[count.index].display_name
  value               = var.named_values[count.index].value
  secret              = var.named_values[count.index].secret # (Optional) Specifies whether the API Management Named Value is secret. Valid values are true or false. The default value is false.
  # value_from_key_vault - (Optional) A value_from_key_vault block as defined below.

  lifecycle {
    ignore_changes = [name]
  }
}

resource "azurerm_api_management_notification_recipient_email" "notification" {
  depends_on = [azurerm_api_management.apim]
  count      = length(var.notifications)

  # notification_type - (Required) The Notification Name to be received. Changing this forces a new API Management Notification Recipient Email to be created. 
  # Possible values are AccountClosedPublisher, BCC, NewApplicationNotificationMessage, NewIssuePublisherNotificationMessage, PurchasePublisherNotificationMessage, QuotaLimitApproachingPublisherNotificationMessage, and RequestPublisherNotificationMessage.
  api_management_id = azurerm_api_management.apim.id
  notification_type = var.notifications[count.index].notification_type
  email             = var.notifications[count.index].email
}

resource "azurerm_api_management_authorization_server" "auth_server" {
  depends_on = [azurerm_api_management.apim]
  count      = length(var.auth_servers)

  name                         = var.auth_servers[count.index].name # (Required) AlphaNumeric. The name of this Authorization Server. Changing this forces a new resource to be created.
  api_management_name          = azurerm_api_management.apim.name
  resource_group_name          = azurerm_api_management.apim.resource_group_name
  authorization_methods        = var.auth_servers[count.index].authorization_methods        # (Required) The HTTP Verbs supported by the Authorization Endpoint. Possible values are DELETE, GET (always), HEAD, OPTIONS, PATCH, POST, PUT and TRACE.
  authorization_endpoint       = var.auth_servers[count.index].authorization_endpoint       # (Required) The OAUTH Authorization Endpoint.
  bearer_token_sending_methods = var.auth_servers[count.index].bearer_token_sending_methods # (Optional) The mechanism by which Access Tokens are passed to the API. Possible values are authorizationHeader and query.
  client_authentication_method = var.auth_servers[count.index].client_authentication_method # (Optional) The Authentication Methods supported by the Token endpoint of this Authorization Server.. Possible values are Basic and Body.
  client_id                    = var.auth_servers[count.index].client_id                    # (Required) The Client/App ID registered with this Authorization Server.
  client_secret                = var.auth_servers[count.index].client_secret                # (Optional) The Client/App Secret registered with this Authorization Server.
  client_registration_endpoint = var.auth_servers[count.index].client_registration_endpoint # (Required) The URI of page where Client/App Registration is performed for this Authorization Server.
  description                  = var.auth_servers[count.index].description                  # (Optional) A description of the Authorization Server, which may contain HTML formatting tags.
  display_name                 = var.auth_servers[count.index].display_name                 # (Required) The user-friendly name of this Authorization Server.
  grant_types                  = var.auth_servers[count.index].grant_types                  # (Required) Form of Authorization Grants required when requesting an Access Token. Possible values are authorizationCode, clientCredentials, implicit and resourceOwnerPassword.
  support_state                = var.auth_servers[count.index].support_state                # (Optional) Does this Authorization Server support State? If this is set to true the client may use the state parameter to raise protocol security.
  token_endpoint               = var.auth_servers[count.index].token_endpoint               # (Optional) The OAUTH Token Endpoint.
  #resource_owner_password = "" # This can only be specified when grant_type includes resourceOwnerPassword.
  #resource_owner_password = "" # This can only be specified when grant_type includes resourceOwnerPassword.

  token_body_parameter {
    name  = var.auth_servers[count.index].token_body_parameter_name
    value = var.auth_servers[count.index].token_body_parameter_value
  }
}


///////////////////////////////////////////////////////////////////////
//////////// RBAC
resource "azurerm_role_assignment" "role_rbac" {
  depends_on = [azurerm_api_management.apim]
  count      = var.enable_rbac_authorization ? length(var.rbac_roles) : 0

  scope                = azurerm_api_management.apim.id
  role_definition_name = var.rbac_roles[count.index].role_definition_name
  principal_id         = var.rbac_roles[count.index].principal_id
}