resource "aws_elastic_beanstalk_application" "aplicacao_beanstalk" {
  name        = var.nome
  description = var.descricao
}

resource "aws_elastic_beanstalk_environment" "ambiente_beanstalk" {
  name                = var.ambiente
  application         = aws_elastic_beanstalk_application.aplicacao_beanstalk.name
  solution_stack_name = "64bit Amazon Linux 2 v3.4.10 running Docker"

  setting { # # instancia 
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.maquina
  }

  setting { # # Maquinas a ser usadas relacionado as requisicoes 
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.max
  }
    setting { # # profile
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.beanstalk_ec2_profile.name
  }
}

resource "aws_elastic_beanstalk_application_version" "default" {
  name        = var.ambiente
  application = var.name
  description = var.descricao
  bucket      = aws_s3_bucket.beanstalk_deplays.id
  key         = aws_s3_object.dockerRun.id
}