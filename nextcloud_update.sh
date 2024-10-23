#!/bin/bash
# Update OS
echo "Update OS"
sudo apt update -q4
sudo apt upgrade -V
sudo apt autoremove -y
sudo apt autoclean -y

# Reset folder permissions
echo "Reset folder permissions"
sudo chown -R www-data:www-data /var/www/nextcloud
sudo find /var/www/nextcloud/ -type d -exec sudo chmod 750 {} \;
sudo find /var/www/nextcloud/ -type f -exec sudo chmod 640 {} \;

# Stop web server
echo "Stop web server"
sudo /usr/sbin/service nginx stop

# Update Nextcloud
echo "Update Nextcloud"
sudo -u www-data php /var/www/nextcloud/updater/updater.phar
sudo -u www-data php /var/www/nextcloud/occ status
sudo -u www-data php /var/www/nextcloud/occ -V
sudo -u www-data php /var/www/nextcloud/occ db:add-missing-primary-keys
sudo -u www-data php /var/www/nextcloud/occ db:add-missing-indices
sudo -u www-data php /var/www/nextcloud/occ db:add-missing-columns
sudo -u www-data php /var/www/nextcloud/occ db:convert-filecache-bigint
sudo -u www-data php /var/www/nextcloud/occ maintenance:repair --include-expensive

# Make sure the user.ini has the needed modification
echo "Make sure the user.ini has the needed modifications"
sudo sed -i "s/output_buffering=.*/output_buffering=0/" /var/www/nextcloud/.user.ini
sudo chown -R www-data:www-data /var/www/nextcloud

# Flush Redis server
echo "Flush Redis server"
redis-cli -h 192.168.0.101 -p 6379 <<EOF
FLUSHALL
quit
EOF

# Perform Nextcloud maintenance
echo "Perform Nextcloud maintenance"
sudo -u www-data php /var/www/nextcloud/occ files:scan --all
sudo -u www-data php /var/www/nextcloud/occ files:scan-app-data
sudo -u www-data php /var/www/nextcloud/occ app:update --all

# Restart PHP and Web server
echo "Restart PHP and Web server"
sudo /usr/sbin/service php8.2-fpm restart
sudo /usr/sbin/service nginx restart

exit 0
