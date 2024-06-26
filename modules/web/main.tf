# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}${var.environment.name}"
  location = "uksouth"
}

# Create the Window App Service Plan
resource "azurerm_service_plan" "appserviceplan" {
  name                = "${var.resource_group_name}api-${var.environment.name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Windows"
  sku_name            = "F1"
}

# Create the web app, pass in the App Service Plan ID
resource "azurerm_windows_web_app" "webapp" {
  name                = "${var.resource_group_name}api-${var.environment.name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.appserviceplan.location
  service_plan_id     = azurerm_service_plan.appserviceplan.id

  site_config {
    always_on = false
    cors {
      allowed_origins = var.cors_allowed_origins
    }
  }
}

#  Deploy code from a private GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id             = azurerm_windows_web_app.webapp.id
  repo_url           = "https://github.com/moodyloo/FlyingFishMenuWeb"
  branch             = var.branch_name
  github_action_configuration {
    code_configuration {
      runtime_stack = "dotnetcore"
      runtime_version = "8.0"
    }

  }
}

resource "azurerm_source_control_token" "source_token" {
  type         = "GitHub"
  token        = var.github_auth
  token_secret = var.github_auth
}