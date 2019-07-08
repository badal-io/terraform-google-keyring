# Terraform Key Ring
An opinionated terraform module that creates key ring and authoritatively handles IAM permissions

Supports following:
- Provisoon Key Ring
- Authoritatively manage key IAM Roles


## Usage


```hcl
module "keyring" {
    source  = "github.com/muvaki/terraform-google-keyring"

    name            = "keyring-name"
    location        = "global"

    iam = {
        "roles/editor" = [
            "user:admin@muvaki.com",
            "serviceAccount:1111111111@cloudbuild.gserviceaccount.com"
        ],
        "project/muvaki/roles/superAdmin" = [
            "group:superadmins@muvaki.com"
        ]
    }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project | Project ID - if not provided it will get it from provider settings | string. | "" | no |
| name | Name of the keyring | string | - | yes |
| key_ring | Name of the key ring that the crypto key belongs to | string | - | yes |
| location | Where the keyring resides | string | - | yes |
| iam |  set of roles with their respective access accounts | map | {} | no |
| module_dependency | Pass an output from another variable/module to create dependency | string | "" | no |

### iam Inputs

IAM input should be passed as roles (key) with list of members as a list value. Roles can be passed as either custom role names (project/project-id/roles/role-name) or standard predefined gcp roles (roles/role-name). Members list is allowed to only have the following prefixes: domain, serviceAccount, user or group.

```hcl
    iam = {
        "roles/editor" = [
            "user:admin@muvaki.com",
            "serviceAccount:1111111111@cloudbuild.gserviceaccount.com"
        ],
        "project/muvaki/roles/superAdmin" = [
            "group:superadmins@muvaki.com"
        ]
```

## Outputs

| Name | Description | 
|------|-------------|
| keyring_id | The ID of the created CryptoKey. Its format is {projectId}/{location}/{keyRingName}/{cryptoKeyName}. |


## Docs:

module reference docs: 
- terraform.io (v0.12.3)
- GCP [IAM](https://cloud.google.com/crypto)

### LICENSE

MIT License