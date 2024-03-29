module "dev" { 
  source = "../modules/web"
    
  environment = {
    name = "dev"
  }

  github_auth = var.github_auth
  
  branch_name = "DEV"

  cors_allowed_origins = ["https://green-plant-03ac6fb03.5.azurestaticapps.net"]
}