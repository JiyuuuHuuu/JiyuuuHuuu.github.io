FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get dist-upgrade -y \
 && apt update -y \
 && apt upgrade -y

RUN apt install -y gcc build-essential make

RUN apt install -y ruby-dev ruby-bundler nodejs

EXPOSE 4000