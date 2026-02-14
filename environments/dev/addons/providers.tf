provider "aws" {
  region = var.aws_region
}

data "terraform_remote_state" "core" {
  backend = "s3"
  config = {
    bucket         = "button0-dev-186582695522-eu-central-1-tfstate"
    key            = "button0/dev/core/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "button0-dev-tf-locks"
    encrypt        = true
  }
}

data "aws_eks_cluster" "this" {
  name = data.terraform_remote_state.core.outputs.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = data.terraform_remote_state.core.outputs.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = [
      "eks",
      "get-token",
      "--cluster-name",
      data.terraform_remote_state.core.outputs.cluster_name,
      "--region",
      var.aws_region
    ]
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = [
        "eks",
        "get-token",
        "--cluster-name",
        data.terraform_remote_state.core.outputs.cluster_name,
        "--region",
        var.aws_region
      ]
    }
  }
}