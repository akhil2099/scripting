#!/bin/bash

read -p "Enter your domain name: " input
name="${input%%.*}"

dbname="${name}_db"
dbuser="$name"
dbpass=$(cat /dev/urandom | tr -dc '[:alnum:][:punct:]' | fold -w 10 | head -n 1)
wppass=$(cat /dev/urandom | tr -dc '[:alnum:][:punct:]' | fold -w 10 | head -n 1)
wpuser="${name}-ADMIN"
email="${name}@gmail.com"

# Create the database and user
sudo mariadb -u root -e "CREATE DATABASE $dbname;"
sudo mariadb -u root -e "CREATE USER '$dbuser'@'localhost' IDENTIFIED BY '$dbpass';"
sudo mariadb -u root -e "GRANT ALL ON $dbname.* TO '$dbuser'@'localhost';"
sudo mariadb -u root -e "FLUSH PRIVILEGES;"


# Download and install WordPress
cd /tmp
sudo wget http://wordpress.org/latest.tar.gz
sudo tar -xvzf latest.tar.gz -C /var/www/html

# Copy and configure wp-config.php
sudo cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
sudo sed -i "s/database_name_here/$dbname/" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/username_here/$dbuser/" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/password_here/$dbpass/" /var/www/html/wordpress/wp-config.php

# Set ownership and permissions
sudo chown -R www-data:www-data /var/www/html/wordpress
sudo find /var/www/html/wordpress -type d -exec chmod 755 {} \;
sudo find /var/www/html/wordpress -type f -exec chmod 644 {} \;

# Check if wp-cli is installed, if not, install it
if [[ ! -f /usr/local/bin/wp ]]; then
    sudo curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    sudo chmod +x /usr/local/bin/wp
    echo "WP-CLI installed successfully."
else
    echo "WP-CLI already installed."
fi

# Configure wp-config.php using wp-cli
cd /var/www/html/wordpress
sudo -u www-data wp config set --dbname=$dbname --dbuser=$dbuser --dbpass=$dbpass --allow-root

# Run WordPress core installation using wp-cli
sudo -u www-data wp core install --url="http://172.16.83.197" --title="$name here !" --admin_user="$wpuser" --admin_password="$wppass" --admin_email="$email" --allow-root

# Configure Apache virtual host
# sudo tee /etc/apache2/sites-available/wordpress.conf > /dev/null <<EOF
# <VirtualHost *:80>
#     ServerAdmin $email
#     DocumentRoot /var/www/html/wordpress/
#     ServerName 172.16.83.197
#     ServerAlias www.$name.com

#     ErrorLog /var/log/apache2/$name_error.log
#     CustomLog /var/log/apache2/$name_access.log common
# </VirtualHost>
# EOF

# Enable the virtual host and restart Apache
sudo a2ensite wordpress.conf
sudo systemctl reload apache2
