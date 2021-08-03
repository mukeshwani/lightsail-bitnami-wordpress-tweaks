#!/bin/bash
sudo chown -R bitnami:daemon /opt/bitnami/apps/wordpress/htdocs/
sudo find /opt/bitnami/apps/wordpress/htdocs/ -type d -exec chmod 0775 {} \;
sudo find /opt/bitnami/apps/wordpress/htdocs/ -type f -exec chmod 0664 {} \;