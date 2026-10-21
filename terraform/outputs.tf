output "static_web_app_url" {
  value = module.staticweb.static_web_app_url
}
output "static_web_app_api_key" {
  value     = module.staticweb.static_web_app_api_key
  sensitive = true
}
output "key_vault_uri" {
  value = module.staticweb.key_vault_uri
}
