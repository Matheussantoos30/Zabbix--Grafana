#!/bin/bash


    if [ "$EUID" -ne 0 ]; then
      echo "Este script precisa ser executado como root."
      exit 1
    fi
    
    # Cria o usuário "matheus"
    useradd -m -s /bin/bash matheus
    
    # Define uma senha para o usuário "matheus"
    echo "matheus:123456" | chpasswd
    echo "root:123456" | chpasswd
    
    # Adiciona o usuário "matheus" ao grupo sudo (ou wheel, dependendo da distribuição)
    usermod -aG sudo matheus
    
    echo "Usuário matheus criado com sucesso e adicionado ao grupo sudo."



