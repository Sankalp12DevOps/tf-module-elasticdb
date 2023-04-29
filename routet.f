resource "aws_route53_record" "elasticroute" {
  zone_id = data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID
  name    = "elastic-${var.ENV}"
  type    = "CNAME"
  records = [aws_elasticache_cluster.example.cache_nodes[0].address]
  ttl     = 5
}