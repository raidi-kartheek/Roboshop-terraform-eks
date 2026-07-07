locals {
  common_name_suffix = "${var.project}-${var.environment}" # roboshop-dev
  vpc_id = data.aws_ssm_parameter.vpc_id.value
}