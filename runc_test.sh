#!/bin/sh

## make sure docker service is running. Else, # service docker start

##1. Creating an OCI comptabile bundle:


mkdir OCI && cd $_
mkdir rootfs
docker export $(docker create hello-world) | tar -xf - -C rootfs
runc spec


## 2. Using runc to run the container


sed -i 's;"sh";"/hello";' config.json
runc run id


##3. Creating and listing a container with runc


sed -i 's;"terminal": true;"terminal": false;' config.json
runc create container_id
runc list

##4. Check state, pause and resume the container


runc state container_id
runc pause container_id
runc state container_id
runc resume container_id
runc state container_id

##5. ps, kill and delete


runc ps container_id
runc kill container_id
runc ps container_id

runc list
runc delete container_id
runc list

