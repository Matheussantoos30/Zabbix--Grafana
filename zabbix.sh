#!/bin/bash

# Atualiza a lista de pacotes
sudo apt-get update

# Baixa e instala a chave GPG do repositório Zabbix
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest+ubuntu24.04_all.deb
sudo dpkg -i zabbix-release_latest+ubuntu24.04_all.deb

# Atualiza novamente a lista de pacotes para incluir o repositório Zabbix
sudo apt-get update

# Instala os pré-requisitos, Instala o Zabbix Server, Frontend e Agent
sudo apt install mysql-server zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent -y




# Configuração do banco de dados MySQL para o Zabbix
sudo mysql -uroot -p -e "CREATE DATABASE zabbix CHARACTER SET utf8 COLLATE utf8_bin;"
sudo mysql -uroot -p -e "CREATE USER 'zabbix'@'localhost' IDENTIFIED BY '123456';"
sudo mysql -uroot -p -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';"
sudo mysql -uroot -p -e "set global log_bin_trust_function_creators = 1;"
sudo mysql -uroot -p -e "FLUSH PRIVILEGES;"
sudo mysql -uroot -p -e "quit;"

# Importa o esquema inicial para o banco de dados Zabbix
sudo zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz| sudo mysql -uzabbix -p zabbix

# Desabilitando a opção log_bin_trust_function_creators
sudo mysql -uroot -p
echo "uroot:123456"

sudo mysql -uroot -p "set global log_bin_trust_function_creators = 0;"
sudo mysql -uroot -p  "quit;"



# Configura o arquivo de configuração do Zabbix Server

# Caminho para o arquivo sshd_config
zabbix_server_path="/etc/zabbix/zabbix_server.conf"

# Linha que você deseja comentar
add_senha="DBPassword"

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
  echo "Este script precisa ser executado como root."
  exit 1
fi

# Comenta a linha no arquivo
sed -i "s/$add_senha/$add_senha = 123456/" "$zabbix_server_path"

echo "Senha adcionada com sucesso em $zabbix_server_path."


# Reinicia os serviços
sudo systemctl restart apache2
sudo systemctl restart zabbix-server zabbix-agent

echo "Instalação do Zabbix concluída. Acesse o frontend em http://seu_endereco/zabbix e faça login com usuário 'Admin' e senha 'zabbix'."
