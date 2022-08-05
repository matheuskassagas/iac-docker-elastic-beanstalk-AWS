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

## Terceiro passo
- Acesse a pasta de prod
```
cd .. 
cd env/prod
terraform init
terraform plan 
terraform apply 
```

## Quarto passo
- Acesse a pasta de prod
```
cd .. 
cd env/homolog
terraform init
terraform plan 
terraform apply 
```