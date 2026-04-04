variable "tenancy_ocid" {
  description = "OCID do tenancy OCI"
  type        = string
}
variable "user_ocid" {
  description = "OCID do usuário OCI"
  type        = string
}
variable "fingerprint" {
  description = "Fingerprint da API Key OCI"
  type        = string
}
variable "private_key_path" {
  description = "Caminho para a chave privada da API Key OCI"
  type        = string
}
variable "region" {
  description = "Região OCI"
  type        = string
}
variable "availability_domain" {
  description = "Availability Domain da VM"
  type        = string
  default     = "rMtA:SA-SAOPAULO-1-AD-1"
}
variable "image_id" {
  description = "OCID da imagem base da VM"
  type        = string
  default     = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaagbb3ikg7maknou7bnigb34coc3hbgthknlfluaj4qypvnxkexsba"
}
variable "ssh_public_key_path" {
  description = "Caminho para a chave pública SSH da VM"
  type        = string
  default     = "~/Music/ssh-key-2026-03-30.key.pub"
}

variable "vm_subnet_id" {
  description = "OCID da subnet onde a VM já existe (importada)"
  type        = string
  default     = "ocid1.subnet.oc1.sa-saopaulo-1.aaaaaaaaewkiytenjlblfhd7whwwnm2x5cbfiahqzuqkqhng2pfyxbjed5pa"
}
