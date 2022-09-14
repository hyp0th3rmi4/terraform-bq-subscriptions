

terraform {

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.32.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
  required_version = "~>1.1.0"
  # optional experiment to enable nested optional parameters
  experiments = [module_variable_optional_attrs]
}