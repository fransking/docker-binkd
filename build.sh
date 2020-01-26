#!/bin/bash

if [ $(arch) == "armv6l" ] 
then
    docker_arch="arm32v6"
elif [ $(arch) == "armv7l" ]
then
    docker_arch="arm32v7"
else
   echo "$(arch) not supported"
   exit -1
fi

docker build \
--build-arg docker_arch=$docker_arch \
--build-arg arch=$(arch) \
-t fransking/binkd-$docker_arch .
