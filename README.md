# vagrant-ubuntu64
Vagrant local development environment with PHP, NGiNX, MySQL (LEMP stack)

Download and install [Vagrant](https://www.vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (if you don’t have them), then install [VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads) to extend the functionality, read the [Docs](https://www.virtualbox.org/manual/ch01.html#intro-installing).

![Image of Yaktocat](./media/vagrant_screenshot.png)

## VirtualBox
**Name your box as (required):** vagrant-ubuntu64  
**Type:** Linux  
**Version:** Ubuntu64  
**Memory Size:** 2048MB  
**Virtual disk type:** VMDK  
**Fixed disk size:** 20 GB (IMHO not less than 10GB)  
**Port forwarding:**
Name | Protocol | Host IP | Host Port | Guest IP | Guest port
--- | --- | --- | --- | --- | ---
SSH | TCP | blank | 2222 | blank | 22

## Ubuntu Server installation
Download the latest [Ubuntu Server](https://ubuntu.com/download/server)   
Follow the installation process (all defaults), however, it is recommended to install OpenSSH Server. For username and password, type: vagrant  

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
On VirtualBox (top menu) click on "Devices" and then select "Insert Guest Additions CD Image", follow the installation process
```
$ sudo mount /dev/cdrom /mnt
$ cd /mnt
$ ls -la
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
$ cd vagrant-ubuntu64
$ vagrant up
$ vagrant ssh
```
MySQL CLI (password vagrant)
```
mysql -u vagrant -p
```

## Support
The above project has been tested with Ubuntu Server 20.04 LTS, for reporting bugs and requesting features it's best to open an issue. It's even better to accompany it with a Pull Request. ;)

## License
GNU General Public License v3.0

## Alternative to Vagrant?
You could use [Docker!](https://github.com/ncklinux/docker-lemp)
