variable "AWS_DEFAULT_REGION" {
  default = ""
}

variable "AWS_ACCESS_KEY_ID" {
  default = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
  default = ""
}

variable "PRIVATE_KEY_PATH" {
  default = "./id_rsa"
}
variable "PUBLIC_KEY_PATH" {
  default = "./id_rsa.pub"
}
variable "EC2_USER" {
  default = "ubuntu"
}