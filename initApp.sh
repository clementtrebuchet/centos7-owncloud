#!/bin/bash

set -e

if [ -f /etc/configured ]; then
        echo '[WARN]Already configured'
else
	if [[ ! -d  /etc/nginx/ssl ]]; then
		mkdir -p /etc/nginx/ssl
	fi 
        echo "[INFO]Gen AutoSSL cert and key..."
	CANO=$(echo "${CN}")
	export CANO
	openssl req -new -x509 -days 365 -nodes -subj "/C=$C/ST=$ST/L=$L/O=$O/OU=$OU/CN=$CN" \
	 -out /etc/nginx/ssl/owncloud.pem -keyout /etc/nginx/ssl/owncloud.key
	echo "[INFO]Config nginx for SSL mode..."
	sed -i 's/;default_charset = "UTF-8"/default_charset = "UTF-8"/' /etc/php.ini
	sed -i "s#ServerName example.com#ServerName $CANO#" /etc/nginx_ssl.conf
	sed -i "s#server_name cloud.example.com#server_name $CANO#" /etc/nginx_ssl.conf
	sed -i "s#-x-replace-cert-x-#/etc/nginx/ssl/owncloud.pem#" /etc/nginx_ssl.conf
	sed -i "s#-x-replace-key-x-#/etc/nginx/ssl/owncloud.key#"  /etc/nginx_ssl.conf
        echo "[INFO]Copy nginx SSL config file"
	cp -p  /etc/nginx_ssl.conf /etc/nginx/nginx_ssl.conf
	cat /etc/nginx/nginx_ssl.conf
	#to include the domain to the hosts
        echo 127.0.0.1 $CANO >> /etc/hosts
        date > /etc/configured
	
fi
echo "[INFO]Starting php-fpm & nginx Services..."
/usr/sbin/php-fpm -F &  /usr/sbin/nginx -c /etc/nginx/nginx_ssl.conf &
echo "[INFO]Go to https://YOUR-HOST/owncloud..."
tail -f /var/log/nginx/*.log &
tail -f /var/log/php-fpm/*.log 
