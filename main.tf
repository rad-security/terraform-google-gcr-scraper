resource "google_iam_workload_identity_pool" "rad_security_gcr_identity_pool" {
  workload_identity_pool_id = "rad-security-identity-pool-gcr"
  display_name              = "RAD Security Identity Pool GCR"
  description               = "Identity pool for RAD Security GCR scraper"
}

resource "google_iam_workload_identity_pool_provider" "rad_aws_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.rad_security_gcr_identity_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "rad-security-gcr-aws-provider"
  display_name                       = "RAD Security AWS Provider GCR"

  attribute_mapping = {
    "google.subject"        = "assertion.arn"
    "attribute.aws_account" = "assertion.account"
  }

  attribute_condition = "assertion.account == '${var.aws_account_id}' && assertion.arn.contains('${var.aws_role_name}')"

  aws {
    account_id = var.aws_account_id
  }
}

resource "google_service_account" "rad_gcr_scraper" {
  account_id   = "rad-security-gcr-scraper"
  display_name = "RAD Security GCR Scraper"
}

resource "google_service_account_iam_binding" "rad_workload_identity_user" {
  service_account_id = google_service_account.rad_gcr_scraper.id
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.rad_security_gcr_identity_pool.name}/attribute.aws_account/${var.aws_account_id}"
  ]
}

resource "google_project_iam_custom_role" "rad_gcr_scraper" {
  project     = local.project_name
  role_id     = "rad_security_gcr_scraper_role"
  title       = "RAD Security GCR Scraper Role"
  description = "RAD Security's Google Cloud Role to access GCR"
  permissions = [
    "artifactregistry.dockerimages.list",
    "artifactregistry.locations.list",
    "artifactregistry.repositories.downloadArtifacts",
    "artifactregistry.repositories.get",
    "artifactregistry.repositories.list"
  ]
}

resource "google_project_iam_binding" "rad_gcr_scraper_access" {
  project = local.project_name
  role    = google_project_iam_custom_role.rad_gcr_scraper.id

  members = [
    "serviceAccount:${google_service_account.rad_gcr_scraper.email}"
  ]
}
