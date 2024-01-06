#!/bin/bash

# Este script configura um IP estático no Ubuntu 20.04

# Nome da interface de rede (pode variar, verifique com ifconfig)
interface="enp0s8"

# Endereço IP desejado
ip_address="192.168.0.115"

# Máscara de sub-rede
subnet_mask="255.255.255.0"

# Gateway padrão
gateway="192.168.0.1"

# DNS primário
dns_primary="192.168.0.1"

# DNS secundário
dns_secondary="8.8.8.8"

# Configuração do endereço IP estático
cat <<EOL > /etc/netplan/50-vagrant.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    $interface:
      addresses: [$ip_address/24]
      gateway4: $gateway
      nameservers:
        addresses: [$dns_primary, $dns_secondary]
      dhcp4: no
EOL

# Aplicar as configurações
netplan apply

echo "Configuração concluída. O IP estático foi configurado para $ip_address"
