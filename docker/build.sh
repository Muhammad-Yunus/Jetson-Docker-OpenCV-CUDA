#!/bin/bash
BASE_IMAGE_REF=
argslist=

PROGNAME=$(basename $0)

usage()
{
    cat >&2 <<EOF
Usage: $PROGNAME [--image imageref]
Options:
    -h, --help         Print this usage message
    -i, --image        Set the base image (and tag) to use for the opencv build
                       When not specified, uses the l4t-base container matching
                       the version of the build host.
EOF
}

# get command line options
SHORTOPTS="hi:"
LONGOPTS="help,image:"

ARGS=$(getopt --options $SHORTOPTS --longoptions $LONGOPTS --name $PROGNAME -- "$@" )
if [ $? != 0 ]; then
   usage
   exit 1
fi

eval set -- "$ARGS"
while true;
do
    case $1 in
        -h | --help)       usage; exit 0 ;;
        -i | --image)      BASE_IMAGE_REF="$2"; shift 2;;
        -- )               shift; break ;;
        * )                break ;;
    esac
done

if [ -z "${BASE_IMAGE_REF}" ]; then
    echo "Finding host L4T version to use with base container"
    L4T_VERSION="32.4.3"
    # See logic at https://github.com/dusty-nv/jetson-containers/blob/master/scripts/l4t_version.sh
    if [ -e /etc/nv_tegra_release ]; then
        L4T_VERSION_STRING=$(head -n 1 /etc/nv_tegra_release)
        if [ ! -z "$L4T_VERSION_STRING" ]; then
            L4T_RELEASE=$(echo $L4T_VERSION_STRING | cut -f 2 -d ' ' | grep -Po '(?<=R)[^;]+')
            L4T_REVISION=$(echo $L4T_VERSION_STRING | cut -f 2 -d ',' | grep -Po '(?<=REVISION: )[^;]+')
            L4T_REVISION_MAJOR=${L4T_REVISION:0:1}
            L4T_REVISION_MINOR=${L4T_REVISION:2:1}
            L4T_VERSION="$L4T_RELEASE.$L4T_REVISION"
            if [[ "${L4T_VERSION}" =~ 32.7.* ]]; then
                L4T_VERSION="32.7.1"
                echo "Substituting L4T version ${L4T_VERSION} since the tag for 32.7.2/32.7.3 doesn't exist"
            fi
            echo "Using L4T version ${L4T_VERSION} based on /etc/nv_tegra_release"
        fi
    argslist="${argslist} L4T_VERSION=${L4T_VERSION}"
    fi
else
    echo "Using base image ${BASE_IMAGE_REF} for container build"
    argslist="${argslist} BASE_IMAGE_REF=${BASE_IMAGE_REF}"
fi

pushd $(dirname $0)/..
docker build -f docker/Dockerfile -t opencv-cuda --build-arg ${argslist} .
