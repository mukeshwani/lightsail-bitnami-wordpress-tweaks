#!/bin/bash
openSSLPath='/test/opt/bitnami/common/bin/openssl'

httpdConfPath='/test/opt/bitnami/apache2/conf/httpd.conf'
wordpressVhostHttpsConfPath='/test/opt/bitnami/apache2/conf/vhosts/wordpress-https-vhost.conf'
wordpressVhostConfPath='/test/opt/bitnami/apache2/conf/vhosts/wordpress-vhost.conf'

#check if using System packages or self-contained version of Bitnami WordPress
if ! [ -f $openSSLPath ]; 
then
echo 'Approach A'
#### System A ####

#enable .htaccess for Bitnami WordPress
sed -i '/<Directory \"\/opt\/bitnami\/wordpress\">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' $wordpressVhostHttpsConfPath
sed -i '/<Directory \"\/opt\/bitnami\/wordpress\">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /test/opt/bitnami/apache2/conf/vhosts/wordpress-vhost.conf

#add cgipassauth directive to allow passing the authentication headers to external API endpoints. This is only if the CGIPassAuth is not present in the file
#grep -q -e 'CGIPassAuth' $wordpressVhostConfPath || sed '/^<Directory \"\/opt\/bitnami\/wordpress\">.*/a CGIPassAuth On' -i.bak $wordpressVhostConfPath
#grep -q -e 'CGIPassAuth' $wordpressVhostHttpsConfPath || sed '/^<Directory \"\/opt\/bitnami\/wordpress\">.*/a CGIPassAuth On' -i.bak $wordpressVhostHttpsConfPath

#in case CGIPassAuth is set to off then run this to turn in on.
#sed '/CGIPassAuth Off/s/Off/On/g' -i.bak $wordpressVhostConfPath
#sed '/CGIPassAuth Off/s/Off/On/g' -i.bak $wordpressVhostHttpsConfPath


#disable pagespeed. This is usually not needed if using other means for optimizations or using a smaller instance.
#sed -e '/Include conf\/pagespeed.conf/ s/^#*/#/' -i $httpdConfPath
#sed -e '/Include conf\/pagespeed_libraries.conf/ s/^#*/#/' -i.bak $httpdConfPath

else
echo 'Approach B'
# System B (legacy)

#enable .htaccess for Bitnami WordPress
#sed -i '/<Directory \"\/opt\/bitnami\/apps\/wordpress\/htdocs\">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /opt/bitnami/apps/wordpress/conf/httpd-app.conf

#disable pagespeed. This is usually not needed if using other means for optimizations or using a smaller instance.
#sed -e '/Include conf\/pagespeed.conf/ s/^#*/#/' -i /home/bitnami/stack/apache/conf/httpd.conf
#sed -e '/Include conf\/pagespeed_libraries.conf/ s/^#*/#/' -i.bak /home/bitnami/stack/apache/conf/httpd.conf

#add cgipassauth directive to allow passing the authentication headers to external API endpoints. This is only if the CGIPassAuth is not present in the file
#grep -q -e 'CGIPassAuth' /opt/bitnami/apps/wordpress/conf/httpd-app.conf || sed '/^<Directory \"\/opt\/bitnami\/apps\/wordpress\/htdocs\">.*/a CGIPassAuth On' -i.bak /opt/bitnami/apps/wordpress/conf/httpd-app.conf

#in case CGIPassAuth is set to off then run this to turn in on.
#sed '/CGIPassAuth Off/s/Off/On/g' -i.bak /opt/bitnami/apps/wordpress/conf/httpd-app.conf

#disable Bitnami banner
#/opt/bitnami/apps/wordpress/bnconfig --disable_banner 1
fi
