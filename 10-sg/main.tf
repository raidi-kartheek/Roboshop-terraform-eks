# Using Open source module
/* module "catalogue" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.common_name_suffix}-catalogue"
  use_name_prefix = false
  description = "Security group for catalogue with custom ports open within VPC, egress all traffic"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

} */


module "sg" {
  count = length(var.sg_names)
  source = "git::https://github.com/raidi-kartheek/terraform-aws-security-group.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = replace(var.sg_names[count.index], "_", "-")
  # sg_description = "Created for ${var.sg_names[count.index]}"
  vpc_id =  local.vpc_id
}

# Frontend accepting traffic from frontend ALB
# resource "aws_security_group_rule" "frontend_frontend_alb" {
#   type              = "ingress"
#   security_group_id = module.sg[9].sg_id # frontend SG ID
#   source_security_group_id = module.sg[11].sg_id # frontend ALB SG ID
#   from_port         = 80
#   protocol          = "tcp"
#   to_port           = 80
# }


