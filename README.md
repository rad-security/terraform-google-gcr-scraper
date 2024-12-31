# terraform-google-gcr-scraper
A terraform module for allowing Rad Security to scan GCR registries in your GCP account.

## Terraform Registry

This module is available in the [Terraform Registry](https://registry.terraform.io/) see [here](https://registry.terraform.io/modules/rad-security/gcr-scraper/google/latest).

## Contributing

The most important thing to be aware of when contributing is that we leverage the [Semantic Release Action](https://github.com/cycjimmy/semantic-release-action) to automate our changelog, see [here](CHANGELOG.md).

This requires us to use [conventional git commits](https://www.conventionalcommits.org/en/v1.0.0/) when committing to this repository.

Each PR merge into the `main` branch will execute the release process defined [here](.github/workflows/release.yml).

## Usage

This module needs a Google provider to be configured. It will create an IAM Service Account in your project called `rad-security-gcr-scraper` and IAM Role. The IAM Role has fine-grained policies attached, which will allow the `imagescan-scraper` role in Rad Security's AWS account to assume the permissions necessary to interact with GCR resources in your account.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_iam_workload_identity_pool.rad_security_gcr_identity_pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.rad_aws_provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_project_iam_binding.rad_gcr_scraper_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_iam_custom_role.rad_gcr_scraper](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_service_account.rad_gcr_scraper](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_binding.rad_workload_identity_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_binding) | resource |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | RAD Security's AWS account ID to authenticate with your Google Cloud project | `string` | `"955322216602"` | no |
| <a name="input_aws_role_name"></a> [aws\_role\_name](#input\_aws\_role\_name) | RAD Security's AWS Role Name to authenticate with your Google Cloud project | `string` | `"imagescan-scraper"` | no |
| <a name="input_gcp_project_name"></a> [gcp\_project\_name](#input\_gcp\_project\_name) | GCP project name (optional - will use current project name if not specified) | `string` | `null` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License
Apache 2 Licensed. See [LICENSE](LICENSE) for full details.
