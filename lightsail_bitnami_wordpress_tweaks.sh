#!/bin/bash
#disable pagespeed. This is usually not needed if using other means for optimizations or using a smaller instance.
sed -e '/Include conf\/pagespeed.conf/ s/^#*/#/' -i /opt/bitnami/apache2/conf/httpd.conf
sed -e '/Include conf\/pagespeed_libraries.conf/ s/^#*/#/' -i.bak /opt/bitnami/apache2/conf/httpd.conf
#add cgipassauth directive to allow passing the authentication headers to external API endpoints. This is only if the CGIPassAuth is not present in the file
grep -q -e 'CGIPassAuth' /opt/bitnami/apps/wordpress/conf/httpd-app.conf || sed '/^<Directory \"\/opt\/bitnami\/apps\/wordpress\/htdocs\">.*/a CGIPassAuth On' -i.bak /opt/bitnami/apps/wordpress/conf/httpd-app.conf
#in case CGIPassAuth is set to off then run this to turn in on.
sed '/CGIPassAuth Off/s/Off/On/g' -i.bak /opt/bitnami/apps/wordpress/conf/httpd-app.conf
#disable Bitnami banner
#/opt/bitnami/apps/wordpress/bnconfig --disable_banner 1

#enable .htaccess for Bitnami WordPress
sed -i '/<Directory \"\/opt\/bitnami\/apps\/wordpress\/htdocs\">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /opt/bitnami/apps/wordpress/conf/httpd-app.conf


## TODO: Update paths in this script like it would be for new instance.

