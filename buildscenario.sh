#!/bin/bash

####################################### PART A 

echo "Cleaning workspace"
sh cleanup.sh

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
NOTE3='Dear Red Hatter, if youre reading this its too late for me, theyve probably told you I "disappeared". I havent managed to complete my work so its up to you to save Canberra.  Doesnt K-osmos G-alaxy B-alistics sound familiar to you? Mark my words, theyre going to ask you to launch the "rocket" so Red Hat will be blamed for all of this. We have one last hope. I managed to create an alternative launch code for the countDown app that will trigger the missile to self-destruct. Please Red Hatter, save us all. The code is 201199. ~ Alan'
DIARY1='Diary 1: The path is set. Soon our competition will be no more. Thank you Red Hat. ~ Alan'

#If the secret project doesnt exist create it
USER=$(oc whoami)
oc projects | grep -q ${USER}-alans-secret-project
if [ $? == 1 ]
then
	oc new-project ${USER}-alans-secret-project
        oc new-app --name mysecretdiary --context-dir providedFiles/hello-world-nginx --build-env WHICHINDEX="${DIARY1}" --strategy docker https://github.com/rohandry/DO180PracticeAssignment
	oc expose svc mysecretdiary
fi

#Project does not exist so create it
oc projects | grep -q ${USER}-alans-test-project 
if [ $? == 1 ]
then
	oc new-project ${USER}-alans-test-project 
else
#Project exists so delete existing apps
	oc project ${USER}-alans-test-project
        for APP in mytest buildapp htmlhelloworld yuricontainer containerbuild mariadbpersistent mytemplate
	do
		oc status | grep -q $APP
		if (( $? == 0 ))
		then
			oc delete all -l app=${APP}
		fi
	done
fi
oc new-app --name mytest --context-dir providedFiles/hello-world-nginx --build-env WHICHINDEX="${NOTE3}" --strategy docker https://github.com/rohandry/DO180PracticeAssignment
oc expose svc/mytest
rm -Rf generatedFiles
