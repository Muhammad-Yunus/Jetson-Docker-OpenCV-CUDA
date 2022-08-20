#!/bin/bash
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
	echo "Using L4T version ${L4T_VERSION} based on /etc/nv_tegra_release"
    fi
fi
pushd $(dirname $0)/..
docker build -f docker/Dockerfile -t opencv-cuda --build-arg L4T_VERSION=${L4T_VERSION} .
