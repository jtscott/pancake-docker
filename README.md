# Pancake App Docker Image
This dockerfile will build a new installation of [Pancake App](https://www.pancakeapp.com/). A script is included to download and unpack your licensed copy of Pancake. This project is not affiliated with Pancake Payments and is provided as-is without any warranty. No software is included or redistributed.

# Requirements
- A valid Pancake App license
- A linked MySQL Container

# Usage
1. Build the image
`docker build -t docker-pancake:latest .`
2. Run the download script to unpack pancake into your mounted volume.
`docker run -v /data/pancake:/var/www/html --rm docker-pancake:latest /opt/download-pancake.sh PAN-YOURLICENSEHERE`
3. Run a MySQL Container
`docker run -d --restart="always" --name mysql-pancake -e MYSQL_ROOT_PASSWORD=YOURPASSWORDHERE -v /data/mysql-pancake:/var/lib/mysql -v /etc/localtime:/etc/localtime:ro mysql:latest`
4. Login to MySQL and create a Pancake database user
~~~~
docker exec -it mysql-pancake /bin/bash -c "export TERM=xterm; exec bash"
mysql -u root -p
CREATE DATABASE pancake_db;
CREATE USER 'pancake_user'@'%' IDENTIFIED BY 'YOURPASSWORDHERE';
GRANT ALTER,SELECT,INSERT,UPDATE,DELETE ON pancake_db.* TO 'pancake_user'@'%';
FLUSH PRIVILEGES;
~~~~
5. Create a pancake container on port 8282
`docker run -d --restart="always" -p 8282:80 --name pancake  -v /data/pancake:/var/www/html -v /etc/localtime:/etc/localtime:ro --link mysql-pancake:mysql docker-pancake:latest`
6. Follow the pancake install wizard.
~~~~
database host: mysql
port: 3306
database: pancake_db
username: pancake_user
password: YOURPASSWORDHERE
~~~~