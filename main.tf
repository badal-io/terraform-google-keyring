data "google_client_config" "default" {}

data "external" "flatten" {
  program = ["docker", "run", "muvaki/terraform-flatten:0.1.0", "iam", "${jsonencode(var.iam)}"]
}

// Locals variables : Module logic
locals {
  iam_permissions = "${compact(split(",", data.external.flatten.result["iam"]))}"
}

resource "google_kms_key_ring" "default" {
  name     = "${var.name}"
  location = "${var.location}"
  project  = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
}

resource "google_kms_key_ring_iam_binding" "default" {
    count     = "${length(local.iam_permissions) > 0 ? length(local.iam_permissions) : 0}"

    key_ring_id = "${google_kms_key_ring.default.id}"
    
    role      = "${trimspace(element(split("|", local.iam_permissions[count.index]), 0))}"
    members   = [
      "${compact(split(" ", element(split("|", local.iam_permissions[count.index]), 1)))}"
    ]

    depends_on = ["google_kms_key_ring.default"]
}
