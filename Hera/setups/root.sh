export ROOTSOURCE=$SWDIR/root/
export ROOTBUILD=$ROOTSOURCE/root-build
export ROOTDIR=$ROOTSOURCE

source $ROOTBUILD/bin/thisroot.sh

export CMAKE_PREFIX_PATH=$ROOTSOURCE/root-install:${CMAKE_PREFIX_PATH}
