# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_endpoint
resource "azurerm_cdn_endpoint" "cdne" {
  depends_on = [data.azurerm_cdn_profile.cdnp]

  name                      = var.name
  profile_name              = data.azurerm_cdn_profile.cdnp.name
  resource_group_name       = data.azurerm_resource_group.rg.name
  location                  = var.location # Norwayeast is not valid, choose Northeurope or global
  is_http_allowed           = true
  is_https_allowed          = true
  content_types_to_compress = var.content_types_to_compress

  # Manage geo-filtering on your endpoint to block or allow content in the selected countries/regions.
  #geo_filter {
  #relative_path = "Not set"      #  The relative path applicable to geo filter.
  #action        = "Allow" # Allow | block
  #country_codes = ["NO"]
  #}
  is_compression_enabled        = local.is_compression_enabled # Must be false if content_types_to_compress is empty, or else fails
  querystring_caching_behaviour = "IgnoreQueryString"
  optimization_type             = "GeneralWebDelivery"

  # (Required) The set of origins of the CDN endpoint. When multiple origins exist, the first origin will be used as primary and rest will be used as failover options
  origin {
    name       = var.origin_name
    host_name  = local.origin_host
    http_port  = 80
    https_port = 443
    # TODO: Origin type is only available from Azure Portal. This must be self configured from the portal
  }
  origin_host_header = local.origin_host #  (Optional) The host header CDN provider will send along with content requests to origins
  origin_path        = var.origin_path   # 
  # Note: global_delivery_rule is only available for Microsoft_Standard CDN profiles
  global_delivery_rule {
    cache_expiration_action {
      behavior = "Override"   # Override | BypassCache | SetIfMissing
      duration = "1.01:01:01" # [d.]hh:mm:ss
    }
    #cache_key_query_string_action {}
    #modify_request_header_action {}
    #url_redirect_action {
    #  redirect_type = "PermanentRedirect" #  (Required) Type of the redirect. Valid values are Found, Moved, PermanentRedirect and TemporaryRedirect
    #  protocol      = "Http"              # http | Https
    #}
    #url_rewrite_action {
    #  source_pattern          = "/"
    #  destination             = "/index.html"
    #  preserve_unmatched_path = false
    #}
  }
  # Note: delivery_rule is only available for Microsoft_Standard CDN profiles
  delivery_rule {
    name  = "HttpsRedirect"
    order = 1 # The order used for this rule, which must be larger than 1.
    #cache_expiration_action {}
    #cache_key_query_string_action {}
    #cookies_condition {}
    #device_condition {}
    #http_version_condition {}
    #modify_request_header_action {}
    request_scheme_condition {
      operator         = "Equal"
      negate_condition = false
      match_values     = ["HTTP"]
    }
    url_redirect_action {
      redirect_type = "Found" # = HTTP 302
      protocol      = "Https" # is case-sensitive
      #hostname      = "" #  (Optional) Specifies the hostname part of the URL.
      #path          = "" #  (Optional) Specifies the path part of the URL. This value must begin with a /.
      #query_string  = "" #  (Optional) Specifies the query string part of the URL. This value must not start with a ? or & and must be in <key>=<value> format separated by &.
      #fragment      = "" #  (Optional) Specifies the fragment part of the URL. This value must not start with a #.
    }
  }
  delivery_rule {
    name  = "index"
    order = 2 # The order used for this rule, which must be larger than 1.
    #cache_expiration_action {}
    #cache_key_query_string_action {}
    #cookies_condition {}
    #device_condition {}
    #http_version_condition {}
    #modify_request_header_action {}
    url_file_extension_condition {
      operator         = "GreaterThan" # Not Greater Than
      negate_condition = true
      match_values     = [0]
      # transforms 
    }
    url_rewrite_action {
      source_pattern          = "/"
      destination             = "/index.html"
      preserve_unmatched_path = false
    }
  }
  tags = var.tags

  lifecycle {
    ignore_changes = [tags["updated_date"], location, origin] # Added Origin to pprevent replacement (destroy)
  }
}

resource "azurerm_cdn_endpoint_custom_domain" "domain" {
  depends_on = [azurerm_cdn_endpoint.cdne]
  count      = length(var.custom_domain) == 0 ? 0 : 1

  name            = replace(var.custom_domain, ".", "-")
  cdn_endpoint_id = azurerm_cdn_endpoint.cdne.id
  host_name       = var.custom_domain
  #custom_https_enabled # At this time only HTTP Custom Domains are supported. HTTPS must be enabled manually 

  lifecycle {
    ignore_changes = [cdn_endpoint_id] # BUG: This must be defined for Staging or else problem. See README 
  }
}
