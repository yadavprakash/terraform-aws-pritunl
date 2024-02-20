output "instance_id" {
  value       = module.pritunl[*].instance_id
  description = "The Pritunl ID."
}

output "tags" {
  value       = module.pritunl.tags
  description = "The pritunl tags."
}
