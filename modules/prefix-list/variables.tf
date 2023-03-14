variable "name" {
  description = "The name of the prefix list. The name must not start with `com.amazonaws`."
  type        = string
  nullable    = false

  validation {
    condition     = !startswith("com.amazonaws", var.name)
    error_message = "The name must not start with `com.amazonaws`."
  }
}

variable "address_family" {
  description = "Address family of this prefix list. Valid values are `IPv4` or `IPv6`."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["IPv4", "IPv6"], var.address_family)
    error_message = "Valid values for `address_family` are `IPv4` or `IPv6`."
  }
}

variable "max_entries" {
  description = "Maximum number of entries that this prefix list can contain. Configured the length of `entries` if not provided."
  type        = number
  default     = null
  nullable    = true
}

variable "entries" {
  description = <<EOF
  (Optional) A set of prefix list entries. Each block of `entries` as defined below.
    (Required) `cidr` - The CIDR block of this entry.
    (Optional) `description` - The description of this entry. Due to API limitations, updating only the description of an existing entry requires temporarily removing and re-adding the entry.
  EOF
  type = set(object({
    cidr        = string
    description = optional(string, "Managed by Terraform.")
  }))
  default  = []
  nullable = false
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "module_tags_enabled" {
  description = "Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
  nullable    = false
}


###################################################
# Resource Group
###################################################

variable "resource_group_enabled" {
  description = "Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
  nullable    = false
}

variable "resource_group_name" {
  description = "The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
  nullable    = false
}

variable "resource_group_description" {
  description = "The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}