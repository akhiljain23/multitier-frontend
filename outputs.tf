# Single value, pending support for multiple output values in schematics_workspace_putputs data source

output "frontend_server_host_ip_addresses" {
  value = [module.frontend.primary_ipv4_address]
}

output "frontend_security_group_id" {
  value = module.frontend.security_group_id
}


