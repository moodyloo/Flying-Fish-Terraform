variable "ARM_SUBSCRIPTION_ID" {
  description = "Subscription Id for Azure"
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
