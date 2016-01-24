#!/bin/bash

CONTAINER_USERNAME=pugachag
IMAGE_NAME=lenaps_image
CONTAINER_NAME=lenaps_container


enter_vm() {
    docker-machine create --driver virtualbox default
    docker-machine start default
    eval "$(docker-machine env default)"
}

build_image() {
    enter_vm
    docker build -t $IMAGE_NAME $1
    docker run -d --name $CONTAINER_NAME -v $HOME/lenaps_data:/home/$CONTAINER_USERNAME/shared $IMAGE_NAME
}

enter_container() {
    enter_vm
    docker start $CONTAINER_NAME
    docker exec -ti -u $CONTAINER_USERNAME $CONTAINER_NAME script -q -c "zsh" /dev/null
}

clean_docker_data() {
    enter_vm
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
    docker rmi $IMAGE_NAME
}

# Main
case $1 in
    enter|'')
        enter_container
        ;;
    build)
        build_image $2
        ;;
    clean)
        clean_docker_data
        ;;
    *)
        echo "Unknown command $1"
        ;;
esac
