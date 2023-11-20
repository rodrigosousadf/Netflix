provider "aws" {
  region = "us-east-1"
}

resource "aws_eks_cluster" "netflix" {
  name     = "netflix"
  role_arn = "arn:aws:iam::373548616758:role/eksctl-netflix-cluster-ServiceRole-OHegmi2O5Yip"
  subnets  = ["subnet-0ed16f540d6ce691b", "subnet-0c7712c3fef8f3d2b", "subnet-02099ef71e65c2411", "subnet-02eb68be145752a3e"]

  vpc_config {
    security_group_ids = ["sg-0c2883f3047f89de2"]
  }
}

resource "aws_eks_cluster_auth" "netflix" {
  name    = aws_eks_cluster.netflix.name
  cluster = aws_eks_cluster.netflix.id

  oidc {
    client_id     = "<seu-client-id>"
    groups_claim  = "groups"
    groups_prefix = "oidc:"
    issuer_url    = "https://oidc.eks.us-east-1.amazonaws.com/id/37C2B3188B1F25B6738BABE3CBF21D64"
  }
}

data "aws_eks_cluster" "netflix" {
  name = aws_eks_cluster.netlix.name
}

resource "aws_launch_configuration" "eks_workers" {
  name = "eks_workers"
  
  image_id = data.aws_eks_cluster.netflix.identity[0].oidc[0].issuer_url

  instance_type = "t2.medium"

  root_block_device {
    volume_size = 20  # Tamanho do disco em GB
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "eks_workers" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 1
  launch_configuration = aws_launch_configuration.eks_workers.id

  vpc_zone_identifier = data.aws_eks_cluster.netflix.resources_vpc_config[0].subnet_ids

  tag {
    key                 = "Name"
    value               = "eks-worker-node"
    propagate_at_launch = true
  }
}

output "eks_workers_asg_name" {
  value = aws_autoscaling_group.eks_workers.name
}

output "eks_workers_instance_ids" {
  value = aws_autoscaling_group.eks_workers.instance_ids
}
