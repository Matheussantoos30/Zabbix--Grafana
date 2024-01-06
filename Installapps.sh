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

# Adiciona "Port 22" ao final do arquivo, se não existir
if ! grep -q "Port 22" "$sshd_config_path"; then
  echo "Port 22" >> "$sshd_config_path"
  echo "Configuração adicionada com sucesso em $sshd_config_path."
else
  echo "A configuração já existe em $sshd_config_path."
fi
