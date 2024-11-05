#!/bin/bash

git submodule update --init --recursive

IMAGE_NAME=personal-website
duration=1

build_container() {
  cd .devcontainer
  docker build . -f Dockerfile -t $IMAGE_NAME
  cd ..
}

if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
  build_container
fi

docker run -it -d -v $(pwd):/home/personal_website -p 4000:4000 $IMAGE_NAME
