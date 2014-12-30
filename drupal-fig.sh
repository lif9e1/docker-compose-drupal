#!/bin/bash

# Wait until the MySQL server is up.
# @todo Switch to a loop which checks for the MySQL server with curl
sleep 8

# Set up the files directory
rm -rf sites/default/files
mkdir -p sites/default/files
chmod 777 -R sites/default/files

# Reset the settings and services files.
cp -f sites/default/default.settings.php sites/default/settings.php && \
  chmod 777 sites/default/settings.php
cp -f sites/default/default.services.yml sites/default/services.yml && \
  chmod 777 /app/sites/default/services.yml

# Install the site.
drush site-install $DRUPAL_PROFILE -y \
  --db-url="$DRUPAL_DBURL" \
  --site-name="$DRUPAL_SITE_NAME" \
  --account-name="$DRUPAL_USER" \
  --account-pass="$DRUPAL_PASS"

# Set up the PHP web server.
php -S 0.0.0.0:80 -t /app
