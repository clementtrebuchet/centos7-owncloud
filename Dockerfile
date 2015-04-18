

#Owncloud 8.0.2 On CentOS 7 

From centos:latest
MAINTAINER C.TREBUCHET

#General variable definition for generation ssl scription keys
ENV C FR
ENV ST PACA
ENV L Cannes
ENV O exemple
ENV OU IT Deparment
ENV CN exemple.com

ADD nginx_ssl.conf /etc
ADD initApp.sh /initApp.sh
RUN chmod +x /initApp.sh

#Install Nginx PHP-FPM wget tar unzip
RUN yum install -y tar  unzip wget nginx php-fpm php-cli php-gd php-mcrypt php-mysql php-pear php-xml bzip2; yum clean all
#Get Owncloud version 8.02 https://download.owncloud.org/ extract it in /usr/share/nginx/
RUN [[ ! -d /usr/share/nginx/ ]] && mkdir -p /usr/share/nginx/
COPY autoconfig.php /var/www/owncloud/config/autoconfig.php
RUN pushd /usr/share/nginx/
RUN wget https://download.owncloud.org/community/owncloud-8.0.2.tar.bz2; tar xfv owncloud-8.0.2.tar.bz2
COPY autoconfig.php /usr/share/owncloud/config/autoconfig.php
RUN chown -R nginx:nginx /usr/share/nginx/owncloud
RUN rm -f owncloud-8.0.2.tar.bz2
RUN popd
#Set user and group to nginx           
RUN sed -i 's/user = apache/user = nginx/' /etc/php-fpm.d/www.conf
RUN sed -i 's/group = apache/group = nginx/' /etc/php-fpm.d/www.conf
RUN chown nginx:nginx /var/lib/php/session/
#Set volume for users data
RUN mkdir -p /datastore; chown nginx:nginx /datastore
#create Volume for the data for owncloud
VOLUME /datastore

EXPOSE 443

CMD["/initApp.sh"]
