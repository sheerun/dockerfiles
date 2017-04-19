FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get -y install module-init-tools git curl vim sudo wget && apt-get clean

RUN echo "Defaults !requiretty\nALL ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/00-sudo && chmod 0400 /etc/sudoers.d/00-sudo

RUN [ -d /etc/init ] && echo "manual" > /etc/init/network-manager.override
