resource "aws_security_group" "allow_tls-robosop_elastiCache" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.ROBO_VPC_ID

  ingress {
    description      = "allow elasticCache Connection"
    from_port        = 6379
    to_port          = 6379
    protocol         = "tcp"
    cidr_blocks      = [data.terraform_remote_state.vpc.outputs.defaultVPCcidr,data.terraform_remote_state.vpc.outputs.vpc_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.ENV}allow_mongo_connection"
  }
}