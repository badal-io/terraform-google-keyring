data "google_client_config" "default" {}

# Locals variables : Module logic
locals {
  iam_permissions = [
    for k, v in var.iam:
    { "role" = k, "members" = v}
  ]
}
resource "google_kms_key_ring" "default" {
  name     = "${var.name}"
  location = "${var.location}"
  project  = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
}

resource "google_kms_key_ring_iam_binding" "default" {
    count     = "${length(local.iam_permissions) > 0 ? length(local.iam_permissions) : 0}"

    key_ring_id = "${google_kms_key_ring.default.id}"
    
    role    = "${trimspace(local.iam_permissions[count.index].role)}"
    members = "${compact(local.iam_permissions[count.index].members)}"

    depends_on = ["google_kms_key_ring.default"]
}
