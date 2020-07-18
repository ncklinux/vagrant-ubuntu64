# vagrant-ubuntu64
VirtualBox Vagrant local development environment (PHP, NGiNX, MySQL)

## VirtualBox
**Name your box as (required):** vagrant-ubuntu64  
**Type:** Linux  
**Version:** Ubuntu64  
**Memory Size:** 2048MB  
**Virtual disk type:** VMDK  
**Fixed disk size:** 20 GB (IMHO not less than 10GB)  
**Port forwarding:** [Name: SSH, Protocol: TCP, Host IP: blank, Host port: 2222, Guest IP: blank, Guest port: 22]

## Ubuntu 20.04 LTS installation
Download the distro https://ubuntu.com/download/server  
Follow the installation procedure (all defaults)  
User: vagrant  
Password: vagrant  

## Ubuntu CLI
Login with vagrant user
```
$ sudo passwd root
$ sudo visudo -f /etc/sudoers.d/vagrant
```
Add the line: vagrant ALL=(ALL) NOPASSWD:ALL
```
$ sudo apt update
$ sudo apt upgrade
$ sudo shutdown -r now
```
Login again
```
$ mkdir -p /home/vagrant/.ssh
$ chmod 0700 /home/vagrant/.ssh
$ wget --no-check-certificate https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys
$ chmod 0600 /home/vagrant/.ssh/authorized_keys
$ chown -R vagrant /home/vagrant/.ssh
$ sudo apt-get install -y openssh-server
$ sudo vim /etc/ssh/sshd_config
```
Uncomment the line: AuthorizedKeysFile
```
$ sudo systemctl restart ssh
$ sudo apt-get install -y gcc build-essential linux-headers-$(uname -r)
```
On VirtualBox (top menu) on Devices->Insert Guest Additions CD Image, follow the installation procedure
```
$ sudo mount /dev/cdrom /mnt
$ cd /mnt
$ sudo ./VBoxLinuxAdditions.run
$ sudo dd if=/dev/zero of=/EMPTY bs=1M
$ sudo rm -f /EMPTY
$ sudo shutdown now
```
On host (physical machine)
```
$ mkdir ~/projects/vagrantBoxes && cd ~/projects/vagrantBoxes
$ vagrant package --base vagrant-ubuntu64
$ vagrant box add vagrant-ubuntu64 package.box
$ git clone git@github.com:ncklinux/vagrant-ubuntu64.git
$ vagrant up
```

Have fun and happy coding!
