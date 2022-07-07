#!/bin/bash

# Скрипт собирает во всех директориях докер контейнеры лежащие в корневой директории

# ***** FUNCTIONS *****
# Function for build docker image in arg directory
build_image () {
    # $1 - directory path argument passed to function

    # version of created image
    version=`cat ./$1/version.txt`

    # build image in directory with concrete version
    # docker build ./$1     -t test_nginx_build:$version
    #|command    |context|image name          |version of image
}

for directory in */ ; do
    build_image "$directory"
done
# Build nginx
echo "-----stage-Build_n_Push_Nginx_image-into-registry------"
cd ./dockerfiles/web/images-base
export NGINX_VERSION=$(cat ./nginx/nginxVersion.txt)
export IMAGE_VERSION=$(cat ./nginx/imageVersion.txt)
export REPO=$(cat ./repo.txt)
export COMMON_IMAGE_NAME=$REPO/basic-nginx-$NGINX_VERSION
docker build --no-cache \
    -f ./nginx/Dockerfile \
    --build-arg NGINX_VERSION \
    --build-arg IMAGE_VERSION \
    -t $COMMON_IMAGE_NAME:$IMAGE_VERSION .
docker tag $COMMON_IMAGE_NAME:$IMAGE_VERSION $COMMON_IMAGE_NAME:latest
docker push $COMMON_IMAGE_NAME:$IMAGE_VERSION
docker push $COMMON_IMAGE_NAME:latest
pwd

#build php-fpm
echo "-----stage-Build_n_Push_PHP_image-into-registry------"
cd ./dockerfiles/web/images-base
export IMAGE_NAME=$(cat ./php-fpm/imageName.txt)
export PHP_VERSION=$(cat ./php-fpm/phpVersion.txt)
export IMAGE_VERSION="$(cat ./php-fpm/imageVersion.txt)"
export REPO=$(cat ./repo.txt)
export COMMON_IMAGE_NAME=$REPO/basic-php-$PHP_VERSION-$IMAGE_NAME
docker build --no-cache \
    -f ./php-fpm/Dockerfile \
    --build-arg PHP_VERSION \
    --build-arg IMAGE_VERSION \
    -t $COMMON_IMAGE_NAME:$IMAGE_VERSION .
docker tag $COMMON_IMAGE_NAME:$IMAGE_VERSION $COMMON_IMAGE_NAME:latest
docker push $COMMON_IMAGE_NAME:$IMAGE_VERSION
docker push $COMMON_IMAGE_NAME:latest
pwd