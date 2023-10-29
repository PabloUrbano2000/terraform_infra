variable "instancias" {
  description = "Nombre de las instancias"

  # para count
  # type        = list(string)

  # para foreach set o map
  # type = set(string)

  # para convertir un list en set (ejemplo para replicar foreach)
  type = list(string)

  # default = ["apache", "mysql", "jumpserver"]

  # ejercicio para dynamic blocks
  default = ["apache"]

}

resource "aws_instance" "public_instance" {
  # por cada indice (count)
  # count                  = length(var.instancias)

  # por cada elemento (foreach)
  # for_each = var.instancias
  # convertir un list en set
  for_each = toset(var.instancias)

  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")
  tags = {
    # por Count
    # "Name" = var.instancias[count.index]

    # por foreach
    "Name" = "${each.value}-${local.sufix}"
  }
}

// Una diferenciacion entre count y foreach al crear recursos
// y tambien en su eliminación es que count crea recursos en base a indices
// por lo que si eliminamos un elemento los indices terminarian moviendose
// en cambio con foreach al crear los elementos los genera como un mapa


# variable "cadena" {
#   type    = string
#   default = "ami-123,AMI-AAV,ami-12f"
# }

# variable "palabras" {
#   type    = list(string)
#   default = ["hola", "como", "estan"]
# }

# variable "entornos" {
#   type = map(string)
#   default = {
#     "prod" = "10.10.0.0/16"
#     "dev"  = "172.16.0.0/16"
#   }
# }


// estructura condicional para crear o no un recurso
resource "aws_instance" "monitoring_instance" {
  # count                  = var.enable_monitoring ? 1 : 0
  count = var.enable_monitoring == 1 ? 1 : 0

  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")
  tags = {
    "Name" = "Monitoreo-${local.sufix}"
  }
}
