

#Owncloud On CentOS 7 from repository

From  owncloud_centos7
MAINTAINER C.TREBUCHET

#get wget as is not included by default
RUN yum install -y wget 
#Set repo{isv:ownCloud:community / owncloud}
RUN pushd /etc/yum.repos.d/
RUN wget http://download.opensuse.org/repositories/isv:ownCloud:community/Fedora_20/isv:ownCloud:community.repo
RUN popd
#get pckgs
RUN yum install -y owncloud
RUN yum install -y php-fpm php-gd php-mysqlnd php-pgsql php-mbstring php-xml php-ldap
RUN yum install -y nginx 
#set some conf on php-fpm              
RUN sed -i 's/user = apache/user = nginx/' /etc/php-fpm.d/www.conf
RUN sed -i 's/group = apache/group = nginx/' /etc/php-fpm.d/www.conf
RUN chown nginx:nginx /var/lib/php/session/
ADD initApp.sh /initApp.sh
RUN chmod +x /initApp.sh

EXPOSE 80

CMD["/initApp.sh"]

