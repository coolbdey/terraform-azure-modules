locals {
  created_datetimeUTC = formatdate("YYYY-MM-DD hh:mm:ss ZZZ", timestamp())

  app_kinds = {
    "windows" = {
      dotnet_framework_version = null # "DOTNETCORE|3.1" # Defaultis v4.0
      linux_fx_version         = null
    }
    "linux" = {
      dotnet_framework_version = null # ""
      linux_fx_version         = var.dotnetcore

    }
  }
  dotnet_framework_version = local.app_kinds[var.app_kind].dotnet_framework_version
  linux_fx_version         = local.app_kinds[var.app_kind].linux_fx_version

}
