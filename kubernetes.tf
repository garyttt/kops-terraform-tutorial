locals {
  cluster_name                 = "kops.learn-devops.online"
  master_autoscaling_group_ids = [aws_autoscaling_group.master-ap-southeast-1a-masters-kops-learn-devops-online.id]
  master_security_group_ids    = [aws_security_group.masters-kops-learn-devops-online.id]
  masters_role_arn             = aws_iam_role.masters-kops-learn-devops-online.arn
  masters_role_name            = aws_iam_role.masters-kops-learn-devops-online.name
  node_autoscaling_group_ids   = [aws_autoscaling_group.nodes-kops-learn-devops-online.id]
  node_security_group_ids      = [aws_security_group.nodes-kops-learn-devops-online.id]
  node_subnet_ids              = [aws_subnet.ap-southeast-1a-kops-learn-devops-online.id]
  nodes_role_arn               = aws_iam_role.nodes-kops-learn-devops-online.arn
  nodes_role_name              = aws_iam_role.nodes-kops-learn-devops-online.name
  region                       = "ap-southeast-1"
  route_table_public_id        = aws_route_table.kops-learn-devops-online.id
  subnet_ap-southeast-1a_id    = aws_subnet.ap-southeast-1a-kops-learn-devops-online.id
  vpc_cidr_block               = aws_vpc.kops-learn-devops-online.cidr_block
  vpc_id                       = aws_vpc.kops-learn-devops-online.id
}

output "cluster_name" {
  value = "kops.learn-devops.online"
}

output "master_autoscaling_group_ids" {
  value = [aws_autoscaling_group.master-ap-southeast-1a-masters-kops-learn-devops-online.id]
}

output "master_security_group_ids" {
  value = [aws_security_group.masters-kops-learn-devops-online.id]
}

output "masters_role_arn" {
  value = aws_iam_role.masters-kops-learn-devops-online.arn
}

output "masters_role_name" {
  value = aws_iam_role.masters-kops-learn-devops-online.name
}

output "node_autoscaling_group_ids" {
  value = [aws_autoscaling_group.nodes-kops-learn-devops-online.id]
}

output "node_security_group_ids" {
  value = [aws_security_group.nodes-kops-learn-devops-online.id]
}

output "node_subnet_ids" {
  value = [aws_subnet.ap-southeast-1a-kops-learn-devops-online.id]
}

output "nodes_role_arn" {
  value = aws_iam_role.nodes-kops-learn-devops-online.arn
}

output "nodes_role_name" {
  value = aws_iam_role.nodes-kops-learn-devops-online.name
}

output "region" {
  value = "ap-southeast-1"
}

output "route_table_public_id" {
  value = aws_route_table.kops-learn-devops-online.id
}

output "subnet_ap-southeast-1a_id" {
  value = aws_subnet.ap-southeast-1a-kops-learn-devops-online.id
}

output "vpc_cidr_block" {
  value = aws_vpc.kops-learn-devops-online.cidr_block
}

output "vpc_id" {
  value = aws_vpc.kops-learn-devops-online.id
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_autoscaling_group" "master-ap-southeast-1a-masters-kops-learn-devops-online" {
  name                 = "master-ap-southeast-1a.masters.kops.learn-devops.online"
  launch_configuration = aws_launch_configuration.master-ap-southeast-1a-masters-kops-learn-devops-online.id
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = [aws_subnet.ap-southeast-1a-kops-learn-devops-online.id]

  tag {
    key                 = "KubernetesCluster"
    value               = "kops.learn-devops.online"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "master-ap-southeast-1a.masters.kops.learn-devops.online"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-ap-southeast-1a"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  tag {
    key                 = "kops.k8s.io/instancegroup"
    value               = "master-ap-southeast-1a"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-kops-learn-devops-online" {
  name                 = "nodes.kops.learn-devops.online"
  launch_configuration = aws_launch_configuration.nodes-kops-learn-devops-online.id
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = [aws_subnet.ap-southeast-1a-kops-learn-devops-online.id]

  tag {
    key                 = "KubernetesCluster"
    value               = "kops.learn-devops.online"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "nodes.kops.learn-devops.online"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  tag {
    key                 = "kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-kops-learn-devops-online" {
  availability_zone = "ap-southeast-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                = "kops.learn-devops.online"
    Name                                             = "a.etcd-events.kops.learn-devops.online"
    "k8s.io/etcd/events"                             = "a/a"
    "k8s.io/role/master"                             = "1"
    "kubernetes.io/cluster/kops.learn-devops.online" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-kops-learn-devops-online" {
  availability_zone = "ap-southeast-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                = "kops.learn-devops.online"
    Name                                             = "a.etcd-main.kops.learn-devops.online"
    "k8s.io/etcd/main"                               = "a/a"
    "k8s.io/role/master"                             = "1"
    "kubernetes.io/cluster/kops.learn-devops.online" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-kops-learn-devops-online" {
  name = "masters.kops.learn-devops.online"
  role = aws_iam_role.masters-kops-learn-devops-online.name
}

resource "aws_iam_instance_profile" "nodes-kops-learn-devops-online" {
  name = "nodes.kops.learn-devops.online"
  role = aws_iam_role.nodes-kops-learn-devops-online.name
}

resource "aws_iam_role" "masters-kops-learn-devops-online" {
  name = "masters.kops.learn-devops.online"
  assume_role_policy = file(
    "${path.module}/data/aws_iam_role_masters.kops.learn-devops.online_policy",
  )
}

resource "aws_iam_role" "nodes-kops-learn-devops-online" {
  name = "nodes.kops.learn-devops.online"
  assume_role_policy = file(
    "${path.module}/data/aws_iam_role_nodes.kops.learn-devops.online_policy",
  )
}

resource "aws_iam_role_policy" "masters-kops-learn-devops-online" {
  name = "masters.kops.learn-devops.online"
  role = aws_iam_role.masters-kops-learn-devops-online.name
  policy = file(
    "${path.module}/data/aws_iam_role_policy_masters.kops.learn-devops.online_policy",
  )
}

resource "aws_iam_role_policy" "nodes-kops-learn-devops-online" {
  name = "nodes.kops.learn-devops.online"
  role = aws_iam_role.nodes-kops-learn-devops-online.name
  policy = file(
    "${path.module}/data/aws_iam_role_policy_nodes.kops.learn-devops.online_policy",
  )
}

resource "aws_internet_gateway" "kops-learn-devops-online" {
  vpc_id = aws_vpc.kops-learn-devops-online.id

  tags = {
    KubernetesCluster                                = "kops.learn-devops.online"
    Name                                             = "kops.learn-devops.online"
    "kubernetes.io/cluster/kops.learn-devops.online" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-kops-learn-devops-online-9349978dc5e05c14000c7943a59573de" {
  key_name = "kubernetes.kops.learn-devops.online-93:49:97:8d:c5:e0:5c:14:00:0c:79:43:a5:95:73:de"
  public_key = file(
    "${path.module}/data/aws_key_pair_kubernetes.kops.learn-devops.online-9349978dc5e05c14000c7943a59573de_public_key",
  )
}

resource "aws_launch_configuration" "master-ap-southeast-1a-masters-kops-learn-devops-online" {
  name_prefix                 = "master-ap-southeast-1a.masters.kops.learn-devops.online-"
  image_id                    = "ami-07dd82a6859b4a2ed"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.kubernetes-kops-learn-devops-online-9349978dc5e05c14000c7943a59573de.id
  iam_instance_profile        = aws_iam_instance_profile.masters-kops-learn-devops-online.id
  security_groups             = [aws_security_group.masters-kops-learn-devops-online.id]
  associate_public_ip_address = true
  user_data = file(
    "${path.module}/data/aws_launch_configuration_master-ap-southeast-1a.masters.kops.learn-devops.online_user_data",
  )

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-kops-learn-devops-online" {
  name_prefix                 = "nodes.kops.learn-devops.online-"
  image_id                    = "ami-07dd82a6859b4a2ed"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.kubernetes-kops-learn-devops-online-9349978dc5e05c14000c7943a59573de.id
  iam_instance_profile        = aws_iam_instance_profile.nodes-kops-learn-devops-online.id
  security_groups             = [aws_security_group.nodes-kops-learn-devops-online.id]
  associate_public_ip_address = true
  user_data = file(
    "${path.module}/data/aws_launch_configuration_nodes.kops.learn-devops.online_user_data",
  )

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_route" "route-kops" {
  route_table_id         = aws_route_table.kops-learn-devops-online.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.kops-learn-devops-online.id
}

resource "aws_route_table" "kops-learn-devops-online" {
  vpc_id = aws_vpc.kops-learn-devops-online.id

  tags = {
    KubernetesCluster                                = "kops.learn-devops.online"
    Name                                             = "kops.learn-devops.online"
    "kubernetes.io/cluster/kops.learn-devops.online" = "owned"
    "kubernetes.io/kops/role"                        = "public"
  }
}

resource "aws_route_table_association" "ap-southeast-1a-kops-learn-devops-online" {
  subnet_id      = aws_subnet.ap-southeast-1a-kops-learn-devops-online.id
  route_table_id = aws_route_table.kops-learn-devops-online.id
}

resource "aws_security_group" "masters-kops-learn-devops-online" {
  name        = "masters.kops.learn-devops.online"
  vpc_id      = aws_vpc.kops-learn-devops-online.id
  description = "Security group for masters"

  tags = {
    KubernetesCluster                                = "kops.learn-devops.online"
    Name                                             = "masters.kops.learn-devops.online"
    "kubernetes.io/cluster/kops.learn-devops.online" = "owned"
  }
}

resource "aws_security_group" "nodes-kops-learn-devops-online" {
  name        = "nodes.kops.learn-devops.online"
  vpc_id      = aws_vpc.kops-learn-devops-online.id
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                                = "kops.learn-devops.online"
    Name                                             = "nodes.kops.learn-devops.online"
    "kubernetes.io/cluster/kops.learn-devops.online" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-kops-learn-devops-online.id
  source_security_group_id = aws_security_group.masters-kops-learn-devops-online.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = aws_security_group.nodes-kops-learn-devops-online.id
  source_security_group_id = aws_security_group.masters-kops-learn-devops-online.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = aws_security_group.nodes-kops-learn-devops-online.id
  source_security_group_id = aws_security_group.nodes-kops-learn-devops-online.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-kops" {
  type              = "ingress"
  security_group_id = aws_security_group.masters-kops-learn-devops-online.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = aws_security_group.masters-kops-learn-devops-online.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = aws_security_group.nodes-kops-learn-devops-online.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-kops-learn-devops-online.id
  source_security_group_id = aws_security_group.nodes-kops-learn-devops-online.id
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-kops-learn-devops-online.id
  source_security_group_id = aws_security_group.nodes-kops-learn-devops-online.id
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-kops-learn-devops-online.id
  source_security_group_id = aws_security_group.nodes-kops-learn-devops-online.id
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-kops-learn-devops-online.id
  source_security_group_id = aws_security_group.nodes-kops-learn-devops-online.id
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-kops" {
  type              = "ingress"
  security_group_id = aws_security_group.masters-kops-learn-devops-online.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-kops" {
  type              = "ingress"
  security_group_id = aws_security_group.nodes-kops-learn-devops-online.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "ap-southeast-1a-kops-learn-devops-online" {
  vpc_id            = aws_vpc.kops-learn-devops-online.id
  cidr_block        = "172.20.32.0/19"
  availability_zone = "ap-southeast-1a"

  tags = {
    KubernetesCluster                                = "kops.learn-devops.online"
    Name                                             = "ap-southeast-1a.kops.learn-devops.online"
    SubnetType                                       = "Public"
    "kubernetes.io/cluster/kops.learn-devops.online" = "owned"
    "kubernetes.io/role/elb"                         = "1"
  }
}

resource "aws_vpc" "kops-learn-devops-online" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                                = "kops.learn-devops.online"
    Name                                             = "kops.learn-devops.online"
    "kubernetes.io/cluster/kops.learn-devops.online" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "kops-learn-devops-online" {
  domain_name         = "ap-southeast-1.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                                = "kops.learn-devops.online"
    Name                                             = "kops.learn-devops.online"
    "kubernetes.io/cluster/kops.learn-devops.online" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "kops-learn-devops-online" {
  vpc_id          = aws_vpc.kops-learn-devops-online.id
  dhcp_options_id = aws_vpc_dhcp_options.kops-learn-devops-online.id
}

terraform {
  required_version = ">= 0.9.3"
}

