output "cluster_ids" {
  value = { for k, v in azurerm_kubernetes_cluster.cluster : k => v.id }
  description = "The IDs of the created AKS clusters."
}

output "cluster_kube_configs" {
  value = { for k, v in azurerm_kubernetes_cluster.cluster : k => v.kube_config_raw }
  description = "The kubeconfig files for the created AKS clusters."
}

output "cluster_node_resource_groups" {
  value = { for k, v in azurerm_kubernetes_cluster.cluster : k => v.node_resource_group }
  description = "The node resource groups for the created AKS clusters."
}

output "system_assigned_identity" {
  value = { for k, v in azurerm_kubernetes_cluster.cluster : k => v.identity.0.principal_id if v.identity.0.type == "SystemAssigned" }
  description = "The Principal ID of the System Assigned Managed Identity for the AKS clusters."
}

output "user_assigned_identity" {
  value = { for k, v in azurerm_kubernetes_cluster.cluster : k => v.identity.0.identity_ids if v.identity.0.type == "UserAssigned" }
  description = "The User Assigned Managed Identity IDs for the AKS clusters."
}

output "both_assigned_identity" {
  value = { for k, v in azurerm_kubernetes_cluster.cluster : k => {
    principal_id = v.identity.0.principal_id,
    identity_ids = v.identity.0.identity_ids
  } if v.identity.0.type == "SystemAssigned, UserAssigned" }
  description = "Both System and User Assigned Managed Identities for the AKS clusters."
}
