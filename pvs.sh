#!/bin/bash

PVS_LIC=/home/PVS-Studio.lic

case $1 in

    prepare)

        if [[ -z $2 ]] || [[ ! -d $2 ]]; then echo "check src path"; exit; fi

        SRC=`realpath $2`

        how-to-use-pvs-studio-free -c 1 $SRC

        ;;

    analyze)

        if [[ -z $2 ]] || [[ ! -d $2 ]]; then echo "check build path"; exit; fi

        BUILD=`realpath $2`
        CWD=`pwd`

        cd $BUILD                                         && \
        make clean                                        && \
        pvs-studio-analyzer trace -- make                 && \
        pvs-studio-analyzer analyze                          \
	        -l $PVS_LIC                                      \
	        -o $CWD/pvs.log                               && \
        plog-converter                                       \
	        -a GA:1,2                                        \
	        -t html                                          \
	        -o $CWD/pvs.html                                 \
	        $CWD/pvs.log

        ;;

    *)
    exit;
        ;;
esac