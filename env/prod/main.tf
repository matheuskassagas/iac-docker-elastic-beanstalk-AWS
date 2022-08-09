module "Producao" {
  source = "../../infra"

  nome = "Producao"
  descricao = "Aplicacao-de-producao"
  max = 5
  maquina = "t2.micro"
  ambiente = "Ambiante-de-producao"
}