provider "google" {
  credentials = file("credentials.json") # comment this line if you are using cloud shell
  project     = var.project_id
  region      = var.region
}

terraform {
  backend "local" {
    path = "./.terraform/state/terraform.tfstate"
  }
}

module "iam_members" {
  source = "./modules/iam_members"

  project_id = var.project_id
}

# module "cloud_sql" {
#   source = "./modules/cloud_sql"

#   region = var.region
# }

module "storage" {
  source = "./modules/storage"

  bucket_name = "${var.project_id}-bucket"
  location    = var.region
}

module "instances" {
  source = "./modules/instances"

  zone = var.zone
}




