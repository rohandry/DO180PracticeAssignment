#!/bin/bash

###### Create a mess of containers and images

echo "Making folders"
mkdir -p generatedFiles/alansDocs
echo "Creating dummy image"
DUMMY=docker.io/bitnami/nginx
podman pull $DUMMY
echo "Creating bogus images"
for NAME in {1..4}
do
		podman tag $DUMMY testimage${NAME}
done	

	echo "Creating bogus containers"
for NAME in {1..4}
do
		podman run --name toDeleteTest${NAME} -d localhost/testimage${NAME}
done

##### Create a container with some changes made to it
echo "Creating changes image and container"
podman run --name practiceContainer -d docker.io/redhat/ubi8-minimal sleep 10s

echo "Making changes"
echo "im so friggen board" > generatedFiles/alansDocs/hardWork.txt
podman cp  generatedFiles/alansDocs/hardWork.txt practiceContainer:/home/
#TODO FIRST NOTE TO REDHATTER
echo "Dear Redhatter, if you're reading this its probably too late.........." > generatedFiles/alansDocs/toRedHatter.txt
podman cp  generatedFiles/alansDocs/toRedHatter.txt practiceContainer:/home/
podman exec -lit mv /home/toRedHatter.txt /home/.toRedHatter.txt
for FILE in fixLogs.sh makeAccounts.sh doGroups.sh setupOpenshift.sh ansiblejob.sh ammenderrors.sh deleteOldUsers.sh
do
	podman exec -lit -- touch /bin/${FILE}
done

###### Debug a boken container
echo "Creating broken Container"
podman run -d --name mysql -e MYSQL_DATABASE=items -e MYSQL_USER=user1 -e MYSQL_PASSWRD=mypa55 -e MYSQL_ROOT_PASSWORD=r00tpa55 -p 30306:3306 docker.io/bitnami/mysql

