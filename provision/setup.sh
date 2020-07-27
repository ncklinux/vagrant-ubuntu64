#!/bin/bash

# Single quotes for special-character passwords
USERANDPASSWORD='vagrant'
PUBLICDIRECTORY='html'

echo "System updates..."
sudo apt update > /dev/null 2>&1
sudo apt -y upgrade > /dev/null 2>&1

echo "Install NGiNX..."
sudo apt install -y nginx > /dev/null 2>&1
sudo nginx -v
sudo systemctl is-enabled nginx
sudo systemctl status nginx

echo "Install PHP..."
sudo apt install -y php php-cli php-fpm php-json php-pdo php-mysql php-zip php-gd  php-mbstring php-curl php-xml php-pear php-bcmath php-imagick > /dev/null 2>&1
sudo php --version
sudo systemctl is-enabled php$(php -v | head -n 1 | cut -d " " -f 2 | cut -f1-2 -d".")-fpm
sudo systemctl status php$(php -v | head -n 1 | cut -d " " -f 2 | cut -f1-2 -d".")-fpm

echo "Install MySQL..."
sudo apt install -y mysql-server > /dev/null 2>&1
sudo mysql -V
systemctl is-enabled mysql
sudo systemctl status mysql
sudo mysql -u root -pvagrant -e "CREATE USER '${USERANDPASSWORD}'@'localhost' IDENTIFIED BY 'vagrant';"
sudo mysql -u root -pvagrant -e "GRANT ALL PRIVILEGES ON * . * TO '${USERANDPASSWORD}'@'localhost';"
sudo mysql -u root -pvagrant -e "FLUSH PRIVILEGES;"
echo "Connect in MySQL with ${USERANDPASSWORD} user: mysql -u ${USERANDPASSWORD} -p"

echo "Stop and disable apache2..."
sudo systemctl stop apache2
sudo systemctl disable apache2
sudo systemctl is-enabled apache2

echo "Install tools..."
sudo apt install -y net-tools mytop > /dev/null 2>&1

echo "Netstat..."
sudo netstat -tupln

# Replace index.html
echo "The standard index.html replaced..."
INDEXTESTTEXT="HTML5 index test page"
INDEXTESTHTML=$(cat <<EOF
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>${INDEXTESTTEXT}</title>
  <meta name="description" content="${INDEXTESTTEXT}">
  <meta name="author" content="vagrant">
</head>
<body>
  <h1>${INDEXTESTTEXT}</h1>
</body>
</html>
EOF
)
echo "${INDEXTESTHTML}" > /var/www/html/index.html
echo "URL: http://localhost:8080"
