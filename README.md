# Aplicacao Docker rodando em ambiente Beanstalk

## Primeiro passo 
- Criar o bucket 
```
cd infra
cd S3-State
terraform init
terraform plan 
terraform apply 
```

---
## Segundo passo 
- Criar a imagem 
```
cd .. 
cd ..
cd api-clientes 
docker build . -t producao:V1
```
```
docker images
```

---
## Terceiro passo
- Acesse a pasta de prod
```
cd .. 
cd env/prod
terraform init
terraform plan 
terraform apply 
```

---
## Quarto passo
- Subir imagem do docker no ecr
- Substitua: 
  - region -> regiao aws
  - aws_account_id -> id aws
```
aws ecr get-login-password --region region | docker login --username AWS --password-stdin aws_account_id.dkr.ecr.region.amazonaws.com
```
- Substitua: 
  - docker_image_id -> id da imagem
  - region -> regiao aws
  - aws_account_id -> id aws
  - my-repository:tag -> nome do ecr 
```
docker tag docker_image_id aws_account_id.dkr.ecr.region.amazonaws.com/my-repository:tag
docker push aws_account_id.dkr.ecr.region.amazonaws.com/my-repository:tag
```
---
**O Dockerrun.aws.json é parte essencial para executarmos uma aplicação no beanstalk**

## Quinto passo
- em /env/prod/Dockerrun.aws.json colocar o nome da imagem da imagem 
- zip o arquivo Dockerrun
```
zip -r producao.zip Dockerrun.aws.json
```
- atualizar o projeto com as alteracoes feitas no s3
```
terraform apply 
```

---
## Atualizar ambiente de versao 
```
aws elasticbeanstalk update-environment --environment-name ambiente-de-producao --version-label ambiente-de-producao
```