locals {
  project_name = coalesce(var.gcp_project_name, data.google_project.current.name)
}
