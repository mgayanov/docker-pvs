#!/bin/bash

source vars

docker   \
    run  \
    --rm \
    -ti  \
    ${PVS_IMAGE}