variable "compartment_id" {
  description = "OCID do compartment da VM"
  type        = string
}

variable "subnet_id" {
  description = "OCID da subnet onde a VM será criada"
  type        = string
}

variable "availability_domain" {
  description = "Availability Domain da VM"
  type        = string
}

variable "image_id" {
  description = "OCID da imagem base"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Caminho para a chave pública SSH"
  type        = string
}
