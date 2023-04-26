resource "aws_elasticache_cluster" "example" {
  cluster_id           = "cluster-example"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = aws_db_parameter_group.default
  engine_version       = "6.2"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.roboshopsubnetGroup.name
  security_group_ids   = aws_security_group.allow_tls-robosop_elastiCache.id
}

resource "aws_db_parameter_group" "default" {
  name   = "${var.ENV}-elastCache-paramGroup"
  family = "mysql5.6"
}

resource "aws_elasticache_subnet_group" "roboshopsubnetGroup" {
  name       = "${var.ENV}_elastiCache_subnetGroup"
  subnet_ids = [data.terraform_remote_state.vpc.outputs.PRVT_SUBNET_IDS]
}