module "dev" { 
  source = "../modules/web"
    
  environment = {
    name = "dev"
  }
  
  branch_name = "DEV"
}