terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Criação Bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "bkt-bbce"
}

resource "aws_s3_bucket_public_access_block" "s3_block" {
    bucket = aws_s3_bucket.s3_bucket.id

 //   block_public_acls = true
 //   block_public_policy = true
 //   ignore_public_acls = true
 //   restrict_public_buckets = true 
} 

 data "aws_eks_cluster" "default" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "default" {
  name = var.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token
}



