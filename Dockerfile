FROM ubuntu:20.04

ENV LC_CTYPE=C.UTF-8

RUN apt update && \
    apt -y dist-upgrade

RUN DEBIAN_FRONTEND="noninteractive" apt -y install \
        build-essential \
        clang \
        git \
        libtool \
        m4 \
        cmake \
        automake \
	    pkg-config \
	    autoconf \
        wget

RUN wget -q -O - https://files.pvs-studio.com/etc/pubkey.txt | \
    apt-key add - && \
    wget -O /etc/apt/sources.list.d/viva64.list https://files.pvs-studio.com/etc/viva64.list && \
    apt update

RUN cd /opt && \
    git clone https://github.com/viva64/how-to-use-pvs-studio-free && \
    cd how-to-use-pvs-studio-free && \
    mkdir build && \
    cd build    && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make install

RUN apt -y install pvs-studio

COPY PVS-Studio.lic /home

COPY pvs.sh /usr/bin