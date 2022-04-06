#!/bin/bash

source vars

if [[ -z $1 ]] || [[ ! -d $1 ]]; then echo "check project path"; exit; fi

PROJECT_PATH=`realpath $1`

if [[ -z $PROJECT_PATH/$2 ]] || [[ ! -d $PROJECT_PATH/$2 ]]; then echo "check src path"; exit; fi
if [[ -z $PROJECT_PATH/$3 ]] || [[ ! -d $PROJECT_PATH/$3 ]]; then echo "check build path"; exit; fi

SRC_PATH=$2
BUILD_PATH=$3

UID=`id -u`
GID=`id -g`

docker run \
    --user=$UID:$GID \
    --rm \
    -ti  \
    -v $PROJECT_PATH:$PROJECT_MNT \
    -v `pwd`/pvs.sh:/usr/bin/pvs.sh \
    $PVS_IMAGE \
    bash -c "cd $PROJECT_MNT && pvs.sh prepare $SRC_PATH && pvs.sh analyze $BUILD_PATH"