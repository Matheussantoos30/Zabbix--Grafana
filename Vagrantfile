Vagrant.configure("2") do |config|
  # Configuração da Box
  config.vm.box = "ubuntu/focal64"

  # Configuração da VM
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 1
   
  end

  config.vm.network "public_network", bridge: "enp0s3"

  # Configuração da Provision
  config.vm.provision "shell", path: "update.sh"
  config.vm.provision "shell", path: "adduser.sh"
  #config.vm.provision "shell", path: "keyboard.sh"
  #config.vm.provision "shell", path: "zabbix.sh"
  config.vm.provision "shell", path: "ssh.sh"
  
  
   
  
end
    



