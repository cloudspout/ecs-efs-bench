provider "aws" {
  # No secrets here - Use env. variables or the ~/.aws/credentials
  # https://www.terraform.io/docs/providers/aws/index.html
  version = "~> 2.57.0"
  region  = var.aws_region
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Project = "ecs-efs-bench"
    Env     = terraform.workspace
  }
}

provider "random" {
  version = "~> 2.2"
}
provider "template" {
  version = "~> 2.1"
}
