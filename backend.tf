terraform {
  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "terraformstatenk4qt9zmx5"
    container_name       = "acme-prod-tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
