#!/bin/bash
crontab -u bitnami -l > crontab_new
echo "*/15 * * * * /home/bitnami/bitnami_tweaks_scripts/bitnami_permissions_reset_commands.sh >> /home/bitnami/bitnami_tweaks_scripts/bitnami_permissions_reset_cron.log 2>&1" >> crontab_new
crontab -u bitnami crontab_new
rm crontab_new