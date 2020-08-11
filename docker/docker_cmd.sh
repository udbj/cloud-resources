# pull an image from docker hub
docker pull ubuntu

# run a loaded image
docker run ubuntu

# run interactive shell for an image
docker run -it ubuntu

# list all images in workspace
docker ps --all

# force stop and remove image
docker rm --force ubuntu

# log into docker account
docker login

# logout from docker account
docker logout

# mount folder to container
docker run -ti -v /Users/dave/Desktop/folder:/usr/src/data coady/pylucene bash

# copy file from desktop to running container
docker cp /Users/dave/Desktop/file da2f:/usr/bin/file

# copy file from running container to desktop
docker cp da2f:/usr/bin/file /Users/dave/Desktop/file

# see downloaded images
docker images

# remove an image
docker image rm 43a8

# stop container 
docker stop 43a8
