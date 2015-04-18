# centos7-owncloud
   - Database : Only Postgresql is available.
   - SSL : Only Auto generated cert available.
   - File System : export /datastore to host.
 
##Run Postgresql container :
sudo docker run --name postgresql -d postgres

##Run Owncloud container : 
sudo docker run -p 443:443 -p 80:80 --link postgresql:db owncloudcentos7:0.1

##Mapping file System :
sudo docker run -p 443:443 -p 80:80 --link postgresql:db -v /datastore:/datastore owncloudcentos7:0.1

