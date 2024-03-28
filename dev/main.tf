module "dev" { 
  source = "../modules/web"
    
  environment = {
    name = "dev"
  }

  github_auth = var.github_auth
  
  branch_name = "DEV"
}