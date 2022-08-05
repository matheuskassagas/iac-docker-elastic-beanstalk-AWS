## Primeiro passo 
- Criar o bucket 
```
cd infra
cd S3-State
terraform init
terraform plan 
terraform apply 
```

## Segundo passo 
```
cd .. 
cd ..
cd api-clientes 
docker build . -t producao:V1
```
```
docker images
```