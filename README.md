# Lightsail Bitnami WordPress Stack Tweaks
Collection of scripts to optimize and modify the Lightsail WordPress stack during instance creation. 

# Purpose
These scripts were created with the purpose of quickly applying optmizations and tweaks to the WordPress blueprint provided by Bitnami. If you are creating a lot of instances in Lightsail, these scripts will save time in creating new instances.

# How To Use


This provides an overview of how to use the scripts and what each of the scripts perform on the istance.


1. Copy and Paste the shell script commands in the Launch script section of the Create Instance screen of the Lightsail Dashboard. These commands will be supplied to you.

2. Once the instance has launched, the commands wil be executed and perform the following changes
   
   1. Disable *Pagespeed* module in Apache
   2. Adds the *CGIPassAuth* flag to the Apache2 configuration file for the WordPress app. Sets the flag to On.
   3. Disable the Bitnami WordPress banner by running the command supplied by Bitnami.
   4. Enable the use of .htaccess files in the WordPress docroot. Bitnami turns this off by default.
   5. Sets up a cron schedule for every 5 mins. Ths cron executes another shell script to reset the WordPress file & folder permissions to default permissions required by Bitnami. The permissions get changed based on front-end activity overtime so this script resets it.

All of this is done inside of a new folder that is created by the commands in the Bitnami home folder.

NOTE: These commands are meant to be run at instance creation saving time, but these can be run adhoc on existing systems as well.
