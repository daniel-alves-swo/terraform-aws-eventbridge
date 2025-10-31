# Nada obrigatório aqui além de agrupar os módulos/arquivos.
# Deixe o Terraform Cloud cuidar de variáveis sensíveis e workspace VCS.

# (Opcional) Tags padrão para todos os recursos
locals {
  default_tags = {
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}
