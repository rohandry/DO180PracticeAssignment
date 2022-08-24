#!/bin/bash
rm -Rf generatedFiles exerciseFiles/*
echo 'podman run -d --name devsql -e MYSQL_DATABASE=items -e MYSQL_USER=user1 -e MYSQL_PASSWRD=mypa55 -e MYSQL_ROOT_PASSWORD=r00tpa55 -p 30306:3306 docker.io/bitnami/mysql' > providedFiles/devSqlLaunch.sh
podman rm -f toDeleteTest1 toDeleteTest2 toDeleteTest3 toDeleteTest4 practiceContainer mysql yuriContainer
podman rmi localhost/testimage1 localhost/testimage2 localhost/testimage3 localhost/testimage4
