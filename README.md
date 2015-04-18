# centos7-owncloud

Database : Only Postgresql is aviable.
SSL : Only Auto generated cert aviable.
File System : export /repodata to host.
 
##Run Postgresql container :
sudo docker run --name postgresql -d postgres

##Run Owncloud container : 
sudo docker run -p 443:443 -p 80:80 --link postgresql:db owncloudcentos7:0.1

##Mapping file System :
sudo docker run -p 443:443 -p 80:80 --link postgresql:db -v /repodata:/repodata owncloudcentos7:0.1

