  #!/bin/bash
  echo "Este es un mensaje" > ~/mensaje.txt
  # actualice el servidor
  yum update -y
  # instalar servicio de apache
  yum install httpd -y
  # servicio de apache arranque automaticamente
  systemctl enable httpd
  systemctl start httpd  