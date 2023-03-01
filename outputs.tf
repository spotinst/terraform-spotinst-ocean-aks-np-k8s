// spotinst/[NAME]
output "ocean_id" {
  value = spotinst_ocean_aks_np.v2.id
  description = "The Ocean cluster ID"
}