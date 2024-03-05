resource "azurerm_public_ip" "acme-prod-public-access-c2f" {
  allocation_method   = "Dynamic"
  location            = "eastus"
  name                = "acme-prod-public-access"
  resource_group_name = "acme-azure-prod"
}

