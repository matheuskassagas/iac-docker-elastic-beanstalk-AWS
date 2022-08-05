# # ROLE EC2
resource "aws_iam_role" "ecr_ec2" {
  name = "ecr_ec2-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}


# # POLICY EC2
resource "aws_iam_role_policy" "ecr_ec2_policy" {
  name = "ecr_ec2_policy"
  role = aws_iam_role.ecr_ec2.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "cloudwatch:PutMetricData",
          "ds:CreateComputer",
          "ds:DescribeDirectories",
          "ec2:DescribeInstanceStatus",
          "logs:*",
          "ssm:*",
          "ec2messages:*",
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "s3:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "ecr_ec2_profile" {
  name = "ecr_ec2_profile"
  role = aws_iam_role.ecr_ec2.name
}

# - cloudwatch:PutMetricData - Usado para colocar informações de métrica no cloudwatch, 
# uma vez que as informações que são enviadas não podem ser editadas.

# - ds:CreateComputer - Cria um objeto com a descrição de uma máquina dentro de um diretório especificado.

# - ds:DescribeDirectories - Obtém informações sobre os diretórios que pertencem à conta. 
# É possível obter informações de diretórios específicos, ou de todos os diretórios.

# - ec2:DescribeInstanceStatus - Pode verificar o status de uma instância especificada ou de todas as instâncias disponiveis. 
# Os status são a zona de disponibilidade, eventos programados, ID da instância, o estado da instância em si 
# (precisa estar em running ou em execução para poder retornar os valores), entre outros que podem ser encontrados na documentação.

# - logs:* - O Beanstalk vai utilizar os vários logs gerados para poder decidir como ele deve agir, criando e destruindo máquinas, 
# mostrando loadbalancers ou mudando rotas.

# - ssm:* - O SSM ou Systems Manager é uma ferramenta para aplicarmos correções nas máquinas criadas e automatizar tarefas em geral. 
# Como não temos acesso direto às máquinas criadas pelo beanstalk, não podemos entrar nelas para aplicar atualizações, por exemplo, então o SSM cuida disso.

# - ec2messages:* - Por ser uma subcategoria dentro dos serviços de autorização, temos sua documentação em um local diferente, 
# mas garante o envio de 6 tipos de mensagens entre máquinas, sendo eles: confirmação, apagar, falha, obter o endpoint, obter mensagens e enviar respostas.

# - ecr:GetAuthorizationToken - Obtém um token de autorização. Esse token funciona como credenciais de autorização do IAM
# e pode ser utilizado para acessar os recursos do Amazon ECR.

# - ecr:BatchCheckLayerAvailability - Verifica a existência de uma ou mais layers de imagens no repositório. Essa permissão é usada
# apenas por partes dentro da AWS e normalmente não é usada por programas externos. Contudo, como o beanstalk é uma parte interna da AWS é necessário que ele tenha acesso a essa permissão.

# - ecr:GetDownloadUrlForLayer - Retorna um link do S3 (onde a Amazon guarda os arquivos) que direciona para os layers da imagem.
# Apenas os layers da imagem desejada podem ser acessados.

# - ecr:GetRepositoryPolicy - Retorna as permisões do repositório desejado, no caso da nossa aplicação, se o repositório for
# privado e não tivermos permisão para acessar, teremos um erro que faz sentido.

# - ecr:DescribeRepositories - Retorna informações do repositório, como data da criação, tipo de criptografia, e mais algumas configurações.

# - ecr:ListImages - Retorna uma lista com todas as imagens dentro do repositório, podendo usar filtros para achar uma imagem escolhida.

# - ecr:DescribeImages - Retorna metadados das imagens no repositório, como data da criação da imagem, tamanho da imagem, o ID de registro, entre outras.

# - ecr:BatchGetImage - Obtém informações detalhadas de uma imagem em específico e em seguida retorna o manifesto da imagem com suas configurações.

# - s3:* - O S3 é onde vamos guardar os dados para a nossa aplicação, sendo assim o benastalk tem que ter acesso para ler os dados que guardarmos,
# e poder ler, editar e excluir os dados temporários, nos buckets que ele tem que criar, editar e destruir. Logo, ele precisa de todas as permissões possíveis.

