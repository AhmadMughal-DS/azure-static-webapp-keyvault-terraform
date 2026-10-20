variable "location" {
  description = "Azure region for the resource group and Key Vault"
  type        = string
  default     = "eastus"
}

variable "swa_location" {
  description = "Static Web Apps region (limited set of regions)"
  type        = string
  default     = "eastus2"
}

variable "project_name" {
  description = "Name prefix applied to all resources"
  type        = string
  default     = "ahmad-swa"
}
