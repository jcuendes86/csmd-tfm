resource "google_compute_network" "custom-network" {
  name                            = var.vpc_name
  project                         = var.project_id
  description                     = var.vpc_description
  auto_create_subnetworks         = var.vpc_auto_create_subnetworks
  routing_mode                    = var.vpc_routing_mode
  delete_default_routes_on_create = var.vpc_delete_default_routes_on_create
  network_firewall_policy_enforcement_order = var.vpc_network_firewall_policy_enforcement_order
}