# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "vagrant-ubuntu64"
  config.vm.hostname = "vagrant"
  config.vm.define "vagrant"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 443, host: 8043
  config.vm.network "forwarded_port", guest: 3306, host: 3309

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.56.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.synced_folder "../data/website_project", "/var/www/html", create: true, group: "www-data", owner: "www-data"

  # Install git, zsh and Oh-My-ZSH
  config.vm.provision :shell, inline: "apt -y install git"
  config.vm.provision :shell, inline: "apt -y install zsh"
  config.vm.provision :shell, privileged: false, inline: "git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh"
  config.vm.provision :shell, privileged: false, inline: "cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc"
  config.vm.provision :shell, inline: "chsh -s /bin/zsh vagrant"
  config.vm.provision :shell, inline: "curl -sL https://deb.nodesource.com/setup_18.x | bash - && apt -y install nodejs"
  config.vm.provision :shell, privileged: false, inline: "node -v && npm -v"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 2
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL

  # Shell script provisioning
  config.vm.provision "shell" do |script|
    script.path = "provision/setup.sh"
  end
end
