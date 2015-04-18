# centos7-owncloud

#Binding to Postgresql 
##Run container
docker run --name postgresql -d postgres

##Binding
docker run -p 443:443 -p 80:80 --link postgresql:db 

##Extending data FS
docker run -p 443:443 -p 80:80 --link postgresql:db -v /repodata:/repodata

