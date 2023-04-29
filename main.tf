resource "aws_elasticache_cluster" "example" {
  cluster_id           = var.ELASTIC_CLUSTER_ID
  engine               = var.ELASTIC_ENGINE
  node_type            = var.ELASTIC_NODETYPE
  num_cache_nodes      = var.ELASTIC_NUM_CACHE_NODES
  parameter_group_name = aws_elasticache_parameter_group.default.name
  engine_version       = var.ELASTIC_ENGINE_VERSION
  port                 = var.ELASTIC_PORT
  subnet_group_name    = aws_elasticache_subnet_group.roboshop_subnetgroup.name
  security_group_ids   = [aws_security_group.allow_tls-robosop_elastiCache.id]
}

resource "aws_elasticache_parameter_group" "default" {
  name       = "${var.ENV}-elastcache-paramgroup"
  family     = "redis6.x"
}

resource "aws_elasticache_subnet_group" "roboshop_subnetgroup" {
  name       = "elasticache-subnetgroup-${var.ENV}"
  subnet_ids =  data.terraform_remote_state.vpc.outputs.PRVT_SUBNET_IDS
}