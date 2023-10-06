variable "ingress_ports" {
  type    = list(number)
  default = [22, 80, 443]
}

variable "name_tag" {
  type = string
}
variable "vpc_id" {
  type = string

}
