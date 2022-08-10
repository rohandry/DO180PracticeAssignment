#!/bin/bash
mkdir assignmentFiles

###### Create a mess of containers and images

echo "Making folders"
mkdir -p assignmentFiles/basicContainer
mkdir assignmentFiles/docs
echo "Creating Containerfile"
#IS THERE A BETTTER PROCESS THAT CAN BE CANCELLED EASIER?
echo 'FROM docker.io/redhat/ubi8-minimal:latest' > assignmentFiles/basicContainer/Containerfile
echo 'USER 1234'
echo 'ENTRYPOINT ["sleep"]' >> assignmentFiles/basicContainer/Containerfile
echo 'CMD ["1d"]' >> assignmentFiles/basicContainer/Containerfile

#echo "Creating bogus images"
#for NAME in {1..4}
#do
#		podman build -t testimage${NAME} assignmentFiles/basicContainer/
#done	

#	echo "Creating bogus containers"
#for NAME in {1..4}
#do
#		podman run --name toDeleteTest${NAME} -d localhost/testimage${NAME}
#done

###### Create a container with some changes made to it
echo "Creating changes image and container"
podman build -t practiceimage assignmentFiles/basicContainer/
podman run --name practiceContainer -d localhost/practiceimage
echo "Making changes"
echo "im so friggen board" > assignmentFiles/docs/hardWork.txt
podman cp  assignmentFiles/docs/hardWork.txt practiceContainer:/home/
#TODO FIRST NOTE TO REDHATTER
echo "Dear Redhatter, if you're reading this its probably too late.........." > assignmentFiles/docs/toRedHatter.txt
podman cp  assignmentFiles/docs/toRedHatter.txt practiceContainer:/home/
podman exec -lit mv /home/toRedHatter.txt /home/.toRedHatter.txt
podman exec -lit chmod 000 /home/.toRedHatter.txt
