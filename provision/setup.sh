#!/bin/bash

# Single quotes for special-character passwords
PASSWORD='vagrant'
PUBLICDIRECTORY='html'

echo "System updates..."
sudo apt update > /dev/null 2>&1
sudo apt -y upgrade > /dev/null 2>&1

echo "Installing packages..."

echo "Install Git..."
sudo apt install -y git > /dev/null 2>&1
sudo git --version

echo "Install NGiNX..."
sudo apt install -y nginx > /dev/null 2>&1
sudo nginx -v
sudo systemctl is-enabled nginx
sudo systemctl status nginx

echo "Install PHP..."
sudo apt install -y php php-cli php-fpm php-json php-pdo php-mysql php-zip php-gd  php-mbstring php-curl php-xml php-pear php-bcmath > /dev/null 2>&1
sudo php --version
sudo systemctl is-enabled php$(php -v | head -n 1 | cut -d " " -f 2 | cut -f1-2 -d".")-fpm
sudo systemctl status php$(php -v | head -n 1 | cut -d " " -f 2 | cut -f1-2 -d".")-fpm

echo "Install MySQL..."
sudo apt install -y mysql-server > /dev/null 2>&1
sudo mysql -V
systemctl is-enabled mysql
sudo systemctl status mysql
