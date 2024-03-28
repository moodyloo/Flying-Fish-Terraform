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

  site_config {}
}

#  Deploy code from a public GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id             = azurerm_windows_web_app.webapp.id
  repo_url           = "https://github.com/moodyloo/FlyingFishMenuWeb"
  branch             = var.branch_name
}