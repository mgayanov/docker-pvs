#!/bin/bash

source vars

docker build -t ${PVS_IMAGE} .
