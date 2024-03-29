variable "github_auth" {
  type = string
}

variable "environment" {
  description = "Development Environment"

  type = object({
    name = string
  })

  default = {
    name = ""
  }
}

variable "resource_group_name" {
  type = string
  default = "FlyingFish"
}

variable "branch_name" {
  default = "master"
}

variable "cors_allowed_origins" {
  type = list(string)
  default = []
}
