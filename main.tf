resource "aws_elasticache_cluster" "example" {
  cluster_id           = "cluster-example"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.default.name
  engine_version       = "6.x"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.roboshopsubnetgroup.name
  security_group_ids   = [aws_security_group.allow_tls-robosop_elastiCache.id]
}

resource "aws_elasticache_parameter_group" "default" {
  name   = "${var.ENV}-elastcache-paramgroup"
  family = "redis6.x"
}

resource "aws_elasticache_subnet_group" "roboshopsubnetgroup" {
  name       = "elasticache_subnetgroup-${var.ENV}"
  subnet_ids =  data.terraform_remote_state.vpc.outputs.PRVT_SUBNET_IDS
}