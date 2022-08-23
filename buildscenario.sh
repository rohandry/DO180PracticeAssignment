#!/bin/bash

####################################### PART A 

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
#FIRST NOTE TO REDHATTER
echo "Dear Red Hatter, this is Alan. I dont have much time. Not everything is as it seems. Do not trust Kosmos Galaxy Ballistics. More instructions to follow. ~ Alan" > generatedFiles/alansDocs/toRedHatter.txt
podman cp  generatedFiles/alansDocs/toRedHatter.txt practiceContainer:/home/
podman exec -lit mv /home/toRedHatter.txt /home/.toRedHatter.txt
for FILE in fixLogs.sh makeAccounts.sh doGroups.sh setupOpenshift.sh ansiblejob.sh ammenderrors.sh deleteOldUsers.sh
do
	podman exec -lit -- touch /bin/${FILE}
done

###### Debug a boken container
echo "Creating broken Container"
podman run -d --name mysql -e MYSQL_DATABASE=items -e MYSQL_USER=user1 -e MYSQL_PASSWRD=mypa55 -e MYSQL_ROOT_PASSWORD=r00tpa55 -p 30306:3306 docker.io/bitnami/mysql

####################################### PART B

oc projects | grep test-project 
#Project does not exist 
if [ $? == 1 ]
then 
	oc new-project test-project 
	oc new-app --name mytest --context-dir providedFiles/hello-world-nginx --strategy docker https://github.com/rohandry/myDO180Assignment
#Project exists
else
	oc project test-project
	oc get pods | grep mytest 
	#App does not exist
	if (( $? == 1 ))
	then 
		oc new-app --name mytest --context-dir providedFiles/hello-world-nginx --strategy docker https://github.com/rohandry/myDO180Assignment
	#App exists 
	else
		oc delete all -l app=mytest
		oc new-app --name mytest --context-dir providedFiles/hello-world-nginx --strategy docker https://github.com/rohandry/myDO180Assignment
	fi 
fi 

