setup root
setup geant4
setup xerces


export GARFIELD_HOME=$SWDIR/garfieldpp
export CMAKE_PREFIX_PATH=$GARFIELD_HOME/install:${CMAKE_PREFIX_PATH}

source ${GARFIELD_HOME}/install/share/Garfield/setupGarfield.sh
