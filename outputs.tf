output "cluster_identities" {
  description = "The identities of the Azure Kubernetes Cluster."
  value = {
    for key, cluster in azurerm_kubernetes_cluster.cluster : key => {
      type         = try(cluster.identity.0.type, null)
      principal_id = try(cluster.identity.0.principal_id, null)
      tenant_id    = try(cluster.identity.0.tenant_id, null)
    }
  }
}

output "cluster_ids" {
  value       = { for k, v in azurerm_kubernetes_cluster.cluster : k => v.id }
  description = "The IDs of the created AKS clusters."
}

output "cluster_kube_configs" {
  value       = { for k, v in azurerm_kubernetes_cluster.cluster : k => v.kube_config_raw }
  description = "The kubeconfig files for the created AKS clusters."
}

output "cluster_node_resource_groups" {
  value       = { for k, v in azurerm_kubernetes_cluster.cluster : k => v.node_resource_group }
  description = "The node resource groups for the created AKS clusters."
}
