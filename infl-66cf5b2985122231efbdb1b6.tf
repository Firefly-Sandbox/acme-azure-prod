resource "azurerm_resource_group" "Acme-Azure-Prod" {
  location = "eastus"
  name     = "Acme-Azure-Prod"
  tags = {
    app = "acme-prod"
  }
}

