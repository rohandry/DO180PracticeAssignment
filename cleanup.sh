#!/bin/bash
rm -Rf assignmentFiles
podman rm -af
podman rmi localhost/testimage1 localhost/testimage2 localhost/testimage3 localhost/testimage4
