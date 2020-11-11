variable "nsxt_cluster_fqdn" {
  type        = string
  description = "the VIP FQDN of your NSX manager cluster"
}

variable "nsxt_cluster_username" {
  type        = string
  description = "the admin username of your NSX manager cluster"
}

variable "nsxt_cluster_password" {
  type        = string
  description = "the admin password of your NSX manager cluster"
}

variable "enable_my_rules" {
  type      = string
  description = "enable firewall rules when provisioning"
  default   = false 
}

variable "nsxt_cluster_allow_unverified_ssl" {
  type        = bool
  description = "Allow unverified SSL?"
  default     = false
}

# variable transport_zones {
#   type = list(string)
# }

# variable tier1_routers {
#   type = list(string)
# }

# variable tier1_routers {
#   type = list(string)
# }

variable tags_yml_file {
  type = string
}

variable groups_yml_file {
  type = string
}

#variable security_policies_yml_file {
#  type = string
#}



