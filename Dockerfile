FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
RUN \
    apt-get update          &&  \
    apt-get --yes upgrade   &&  \
    apt-get --yes install       \
        nginx

ADD nginx.conf /etc/nginx/nginx.conf
ADD app/atc/app/static /opt/atc/app/static
