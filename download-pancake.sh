#!/bin/sh -e
curl http://manage.pancakeapp.com/download/$1 > pancake.zip \
&& unzip pancake.zip \
&& mv pancake_4/pancake/* /var/www/html \
&& chmod -R 777 /var/www/html/system/pancake \
&& chmod -R 777 /var/www/html/uploads \
&& chown -R www-data:www-data /var/www/html \
&& rm pancake.zip \
&& rm -rf pancake_4/