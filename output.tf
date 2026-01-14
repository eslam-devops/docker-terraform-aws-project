output "alb_dns_name" {
  description = "ALB DNS name"
  value       = module.alb_asg.alb_dns_name
}

# output "cloudfront_domain" {
#   description = "CloudFront distribution domain"
#   value       = module.cloudfront.domain_name
# }
# output "cloudfront_domain" {
#   description = "CloudFront distribution domain name"
#   value       = module.cloudfront.cloudfront_domain_name
# }


# output "ssh_command" {
#   description = "SSH command"
#   value       = "ssh -i ~/.ssh/eslam_main_key ec2-user@$(terraform output -raw alb_dns_name)"
# }

# output "alb_dns_name" {
#   value = module.alb_asg.alb_dns_name
# }

output "website_url" {
  value = "http://${module.alb_asg.alb_dns_name}"
}
output "asg_instance_ids" {
  value = data.aws_instances.asg_instances.ids
}

