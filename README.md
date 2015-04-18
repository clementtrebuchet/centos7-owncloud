# centos7-owncloud
   
   - CentOS 7
   - Owncloud 8.0.2
   - Database : Both SQLite & MySQL are available.
   - SSL : Only Auto generated cert available.
   - File System : export /datastore to host.

##Get MySQL from official repo
	sudo docker pull mysql
##Run MySQL container :
	sudo docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag

… where some-mysql is the name you want to assign to your container, my-secret-pw is the password to be set for the MySQL root user and tag is the tag specifying the MySQL version you want. 

##Run Owncloud container : 
	sudo docker run -p 443:443 -p 80:80 --link some-mysql:mysql owncloudcentos7:0.1

##Mapping file System :
	sudo docker run -p 443:443 -p 80:80 --link some-mysql:mysql -v /datastore:/datastore owncloudcentos7:0.1

##Docker Tips 
    - delete all unwanted none images
    	sudo docker images |grep none |awk -F" " '{print $3}' |xargs sudo docker rmi
