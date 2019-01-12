variable "module_dependency" {
  type        = "string"
  default     = ""
  description = "This is a dummy value to great module dependency"
}

variable "name" {
    description = "name for the crypto key"
    type        = "string"
}

variable "location" {
    description = "The Google Cloud Platform location for the KeyRing. A full list of valid locations can be found by running gcloud kms locations list."
    type        = "string"
}

variable "project" {
  description = "The project in which the resource belongs. If it is not provided, the provider project is used."
  type        = "string"
  default     = ""
}
variable "iam" {
  description = "IAM Permissions for the bucket."
  type        = "map"
  default     = {}
}