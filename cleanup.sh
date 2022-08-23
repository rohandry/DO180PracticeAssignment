#!/bin/bash
rm -Rf generatedFiles
podman rm -f toDeleteTest1 toDeleteTest2 toDeleteTest3 toDeleteTest4 practiceContainer mysql
podman rmi localhost/testimage1 localhost/testimage2 localhost/testimage3 localhost/testimage4
oc delete project test-project 
