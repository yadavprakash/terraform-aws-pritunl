output "private_ip" {
  value       = module.ec2.private_ip
  description = "Private IP of instance."
}

output "tags" {
  value       = module.ec2.tags
  description = "The instance tags."
}

output "instance_id" {
  value       = module.ec2[*].instance_id
  description = "The instance ID."
}
