# # Variables
# variable "domain_name" {
#   description = "The domain name for your Route 53 hosted zone"
#   type        = string
#   default     = "my-domain.com" # Replace with your domain
# }

# # Create Route 53 Hosted Zone
# resource "aws_route53_zone" "my_zone" {
#   name = var.domain_name
# }

# # AWS Tomcat Weighted Record
# resource "aws_route53_record" "aws_tomcat" {
#   zone_id = aws_route53_zone.my_zone.id
#   name    = "tomcat.${var.domain_name}"
#   type    = "A"

#   ttl = 60

#   set_identifier = "aws-tomcat"
#   records        = [aws_instance.tomcat.public_ip]

#   weighted_routing_policy {
#     weight = 50
#   }
# }

# # Azure Tomcat Weighted Record
# resource "aws_route53_record" "azure_tomcat" {
#   zone_id = aws_route53_zone.my_zone.id
#   name    = "tomcat.${var.domain_name}"
#   type    = "A"

#   ttl = 60

#   set_identifier = "azure-tomcat"
#   records        = [azurerm_public_ip.tomcat_pub_ip.ip_address]

#   weighted_routing_policy {
#     weight = 50
#   }
# }

# # Output the created domain name
# output "route53_tomcat_record" {
#   value       = "http://tomcat.${var.domain_name}:8080"
#   description = "Access Tomcat application using this URL"
# }
