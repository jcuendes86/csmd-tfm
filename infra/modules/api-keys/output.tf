output "api_key_string" {
  description = "API Key string"
  value       = try(google_apikeys_key.api_key.key_string, null)
  sensitive   = true
}