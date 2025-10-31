terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.4.0"
    }
  }
  # No backend block aqui: o Terraform Cloud vai gerenciar o state pelo workspace VCS.
}

provider "aws" {
  region = var.region

  # Opcional: tags padrão
  default_tags {
    tags = {
      Project   = var.project_name
      ManagedBy = "Terraform"
    }
  }
}
