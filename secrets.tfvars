variable "private_key" {
  description = "Private key for accessing the Ubuntu instance"
  type        = string
  default     = lookup(var.secrets, "private_key")
}

variable "secrets" {
  description = "Github secrets"
  type        = map(string)
  default     = {
    private_key = ""
  }
}
