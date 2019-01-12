output "keyring_id" {
  value       = "${google_kms_key_ring.default.id}"
  description = "The ID of the created KeyRing. Its format is {projectId}/{location}/{keyRingName}."
}

output "keyring_name" {
  value       = "${google_kms_key_ring.default.name}"
  description = "Name of the keyring"
}