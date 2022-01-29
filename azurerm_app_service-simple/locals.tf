locals {
  #  linux_fx_version = "DOTNETCORE|3.1"
  app_kinds = {
    "windows" = {
      dotnet_framework_version = null # "DOTNETCORE|3.1" # Defaultis v4.0
      linux_fx_version         = null
      windows_fx_version       = var.dotnetcore
    }
    "linux" = {
      dotnet_framework_version = null # ""
      linux_fx_version         = var.dotnetcore
      windows_fx_version       = null
    }
  }
  default_documents        = sort(["index.html", "index.js", "default.html", "default.aspx", "hostingstart.htm", "iisstart.htm"])
  dotnet_framework_version = local.app_kinds[var.app_kind].dotnet_framework_version
  linux_fx_version         = local.app_kinds[var.app_kind].linux_fx_version
  windows_fx_version       = local.app_kinds[var.app_kind].windows_fx_version
}
