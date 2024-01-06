# Instala o Open SSh - Server

echo "instalando o Open SSh Server"
    
    sudo  apt install openssh-server

#!/bin/bash

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
  echo "Este script precisa ser executado como root."
  exit 1
fi

# Caminho para o arquivo sshd_config
sshd_config_path="/etc/ssh/sshd_config"

# Verifica se o arquivo existe
if [ ! -e "$sshd_config_path" ]; then
  echo "O arquivo $sshd_config_path não foi encontrado."
  exit 1
fi

# Adiciona "PasswordAuthentication yes" ao final do arquivo, se não existir
if ! grep -q "PasswordAuthentication yes" "$sshd_config_path"; then
  echo "PasswordAuthentication yes" >> "$sshd_config_path"
  echo "Configuração adicionada com sucesso em $sshd_config_path."
else
  echo "A configuração já existe em $sshd_config_path."
fi


#ADCIONA A LINHA "PASSWORDAUTHENTICATION" NO ARQUIVO SSHD_CONFIG

#!/bin/bash

# Caminho para o arquivo sshd_config
sshd_config_path="/etc/ssh/sshd_config"

# Linha que você deseja comentar
linha_a_comentar="PasswordAuthentication no"

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
  echo "Este script precisa ser executado como root."
  exit 1
fi

# Comenta a linha no arquivo
sed -i "s/$linha_a_comentar/#$linha_a_comentar/" "$sshd_config_path"

echo "Linha comentada com sucesso em $sshd_config_path."

#DESCOMENTA A LINHA #PORT 22

# Caminho para o arquivo sshd_config
sshd_config_path="/etc/ssh/sshd_config"

# Linha que você deseja descomentar
linha_a_descomentar="#Port 22"

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
  echo "Este script precisa ser executado como root."
  exit 1
fi

# Descoomenta a linha no arquivo
sed -i "s/$linha_a_descomentar/$linha_a_descomentar/" "$sshd_config_path"

echo "Linha descomentada com sucesso em $sshd_config_path."


#REINICIA O SERVIÇO SSH
echo "Reiniciando o SSH"
sudo service ssh restart