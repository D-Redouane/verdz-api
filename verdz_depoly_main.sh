#!/bin/bash

# ----------------
# ----------------
# Be careful to update two commands: 
# command b.1 (the git clone by token) and 
# command c.3 (the IP address in the Apache configuration)
# ----------------
# ----------------

# after creating an instance on AWS, you need to run this script to install the necessary packages and setup the project
# create a file name it for example verdz-deply.sh ----------------------> sudo nano verdz-deply.sh
# copy the content of this file and paste it in the file you created ------> Ctrl + Shift + V    (: 
# run the following command to make the file executable -------------------> sudo chmod +x verdz-deply.sh
# run the following command to execute the file ---------------------------> sudo ./verdz-deply.sh
# after running the script, you can access the project by entering the IP address of the instance in the browser
# remark: you must make yes answer for composer install output, fill the ssl fileds as follows: (dz,ghardaia,ghardaia,verdz,far3,verdz,verdz@gmail.com)
# remark: you must don't make any code for the database password, just press enter
# remark: you must make yes answer for the any install output of packages
# remark: you must make make the github username and the password will not be the user password but you have to create a access token from the github account settings
# remark: you must verify the .env file for any changes generally
# remark: you must change the branch to on of the deployment branches 

# Function to print error message and the command that failed
print_error() {
    echo "Error occurred in command: $1"
}

# Stop execution on error
set -e

# Trap errors and call print_error function
trap 'print_error "$BASH_COMMAND"' ERR



# ------------------------------
# A) Section for building issues
# ------------------------------

# a.1. Update the package manager
sudo yum update -y

# a.2. Install necessary packages
sudo yum install git nodejs npm -y

# a.3. Create the web server directory
sudo mkdir -p /var/www/html


# ------------------------------
# B) Section for other packages-
# ------------------------------

# b.1. Install necessary packages for PHP and Apache
sudo dnf install -y php8.2 php8.2-cli php8.2-common php8.2-fpm php8.2-mbstring php8.2-mysqlnd php8.2-xml php8.2-opcache php8.2-gd php8.2-zip

# b.2. Install Apache, PHP, Composer, and SSL module
sudo yum install httpd php composer mod_ssl -y


# ------------------------------
# C) SSL Configuration ---------
# ------------------------------

# c.1. Create directories for SSL certificates
sudo mkdir -p /etc/ssl/private /etc/ssl/certs

# c.2. Generate a self-signed SSL certificate
sudo openssl req -newkey rsa:2048 -nodes -keyout /etc/ssl/private/selfsigned.key -x509 -days 365 -out /etc/ssl/certs/selfsigned.crt

# c.3. Edit the Apache configuration to include SSL settings
sudo tee -a /etc/httpd/conf.d/verdz.conf > /dev/null <<EOF
# HTTP Configuration
<VirtualHost *:80>
    ServerName your.server.ip.address
    Redirect permanent / https://your.server.ip.address/
</VirtualHost>

# HTTPS configuration
<VirtualHost *:443>
    ServerName your.server.ip.address

    DocumentRoot /var/www/html/verdz/public
    <Directory /var/www/html/verdz>
        AllowOverride All
    </Directory>

    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/selfsigned.crt
    SSLCertificateKeyFile /etc/ssl/private/selfsigned.key

    # Optional: add security headers
    Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains"
    Header always set X-Frame-Options "DENY"
    Header always set X-XSS-Protection "1; mode=block"
    Header always set X-Content-Type-Options "nosniff"
</VirtualHost>
EOF


# ------------------------------
# D) Install MySQL--------------
# ------------------------------

# d.1. Download the MySQL repository configuration package
sudo wget https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm 

# d.2. Install the MySQL repository configuration package
sudo dnf install mysql80-community-release-el9-1.noarch.rpm -y

# d.3. Install MySQL server
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023

# d.4. Install MySQL server
sudo dnf install mysql-community-client -y

# d.5. Edit the MySQL configuration for initial setup
sudo tee -a /etc/my.cnf > /dev/null <<EOF
[mysqld]
skip-grant-tables
EOF


# ------------------------------
# E) Install Yarn --------------
# ------------------------------

# e.1. Add the Yarn repository
curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo

# e.2. Import Yarn GPG key
sudo rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg

# e.3. Install Yarn
sudo yum install yarn -y

# e.4. Verify the installation
yarn --version


# ------------------------------
# F) Start services
# ------------------------------

# f.1. Install MySQL Server and Client
sudo dnf install mysql-server mysql-community-client -y

# f.2. Start and enable MySQL service
sudo systemctl enable mysqld
sudo systemctl start mysqld

# f.3. Enable the Apache web server
sudo systemctl enable httpd

# f.4. Start the Apache web server
sudo systemctl start httpd

# f.5. Restart MySQL service to apply changes
sudo systemctl restart mysqld

# f.6. Restart Apache to apply configuration changes
sudo systemctl restart httpd

# f.7. Restart PHP-FPM service to apply PHP module changes
sudo systemctl restart php-fpm


# ------------------------------
# G) Project setup
# ------------------------------

# g.1. Navigate to the web server directory
cd /var/www/html

# g.2. Clone the project from GitHub
sudo git clone https://github.com/D-Redouane/verdz-api.git

# g.3. Enter the project directory
cd verdz-api/

# g.4. Install npm dependencies
sudo npm install

# g.5. Build frontend assets with Vite and Node.js
# sudo node --max-old-space-size=600 ./node_modules/.bin/vite build

# g.6. Install Composer dependencies
sudo composer install

# g.7. Set ownership for the 'storage' directory
sudo chown -R apache:apache storage

# g.8. Set ownership for the 'bootstrap/cache' directory
sudo chown -R apache:apache bootstrap/cache

# g.9. Copy the example environment file
sudo cp .env.example .env

# g.10. Generate an application key
sudo php artisan key:generate

# g.11. Generate a JWT secret key
sudo php artisan jwt:secret

# g.12. Append database host to .env file
sudo tee -a .env > /dev/null <<EOF
DB_HOST=localhost
EOF

# g.13. Create a symbolic link for the storage directory
sudo php artisan storage:link

# g.14. Create a database using MySQL
mysql -u root -p <<MYSQL_SCRIPT
create database verdz;
exit
MYSQL_SCRIPT

# g.15. Run database migrations with seeding
sudo php artisan migrate --seed


# ------------------------------
# H) Build & swap configuration
# ------------------------------

# h.1. allocate 4GB of swap space
fallocate -l 4G /swapfile

# h.2. set the correct permissions
chmod 600 /swapfile

# h.3. make the swap space available
mkswap /swapfile

# h.4. enable the swap space
swapon /swapfile

# h.5. make the swap space permanent
echo '/swapfile swap swap defaults 0 0' | sudo tee -a /etc/fstab

# h.6. Check current swappiness value
cat /proc/sys/vm/swappiness

# h.7. Set swappiness to 10 (lower value)
sysctl vm.swappiness=10

# h.8. To make it permanent, add it to /etc/sysctl.conf
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf

# h.9. Build frontend assets with Vite and Node.js
NODE_OPTIONS="--max-old-space-size=4096" npm run build
# sudo node --max-old-space-size=600 ./node_modules/.bin/vite build
