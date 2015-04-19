# centos7-owncloud
   
   - CentOS 7
   - Owncloud 8.0.2 (from source)
   - Database : Both SQLite & MySQL are available.
   - SSL : Only auto generated cert available.
   - File System : expose /datastore to host.

##Get MySQL from official repo :
	sudo docker pull mysql

##Run MySQL container :
	sudo docker run --name ownmysql -e MYSQL_ROOT_PASSWORD=123456 -d mysql

 - where ownmysql is the name you want to assign to your container, 123456 is the password to be set for the MySQL root user. 

##Run Owncloud container : 
	sudo docker run --name owncloud -p 443:443 -p 80:80 --link ownmysql:mysql  centos7-owncloud

##Run Owncloud container with SSL parameters :
	sudo docker run --name owncloud -p 443:443 -p 80:80 --link ownmysql:mysql -e C=FR -e ST=MIDI-PYRENEES -e L=TOULOUSE -e O=dockerapp.tk -e OU=AppLAB -e CN=example.com centos7-owncloud

##Map file system :
	sudo docker run --name ownmysql -p 443:443 -p 80:80 --link ownmysql:mysql -v /var/datastore:/datastore centos7-owncloud

##Tips :
    - Debug bash console 
	sudo docker run --name ownmysql -i -t -p 443:443 -p 80:80 --link ownmysql:mysql -v /var/datastore:/datastore centos7-owncloud bash
	
    - Start initApp (init owncloud)
	[root@ee2213426597 /]bash initApp.sh
    - Env 
	[root@ee2213426597 /]# env
	C=FR
	HOSTNAME=ee2213426597
	MYSQL_ENV_MYSQL_ROOT_PASSWORD=123456
	TERM=xterm
	OU=dockerApp LAB
	L=TOULOUSE
	O=dockerapp.tk
	MYSQL_PORT_3306_TCP_PORT=3306
	MYSQL_PORT_3306_TCP=tcp://172.17.0.174:3306
	PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
	PWD=/
	MYSQL_ENV_MYSQL_VERSION=5.6.24
	SHLVL=1
	HOME=/root
	MYSQL_NAME=/owncloud/mysql
	MYSQL_PORT_3306_TCP_PROTO=tcp
	MYSQL_PORT_3306_TCP_ADDR=172.17.0.174
	LESSOPEN=||/usr/bin/lesspipe.sh %s
	CN=main.dockerapp.tk
	MYSQL_ENV_MYSQL_MAJOR=5.6
	MYSQL_PORT=tcp://172.17.0.174:3306
	ST=MIDI-PYRENEENS

