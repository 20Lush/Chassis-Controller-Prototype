#!/bin/bash

############################# CONFIGURABLES #############################################################
# Name of the project, the binary will end up looking like <project_name>.uf2                           #
TOP_LVL_PROJECT_NAME="chassis-prototype"                                                                #
# Board name we are building for, typically a flavor of rp2040. Defaults to sparkfun promicro           #
BOARD_NAME="sparkfun_promicro"                                                                          #
#########################################################################################################

# Default directory to build into
BUILD_DIRECTORY="$PWD/../build"
BUILD_TYPE="Debug"

# Default directory of cmake boilerplate scripts
CMAKE_BOILERPLATE="$PWD/../.CMake-Boilerplate"

# Default directory to install package to
INSTALL_DIRECTORY="${BUILD_DIRECTORY}/install"

# This directory, where the scripts live
SCRIPT_DIRECTORY="$PWD"

# Directive to run ./upload.sh (forced) after build
UPLOAD=false

# Directive to delete the build directory before a new build
CLEAN=false

# Handle command line arguments
while getopts 'b:hn:p:uc' opt; do
    case "$opt" in
        b)
            BUILD_TYPE="$OPTARG"
            ;;
        h)
            echo "====== HELP DIALOGUE ===================================================================="
            echo "  Usage: $(basename $0) [-h help] [-b built type(Debug or Release)] [-t enable testing]  "
            echo "========================================================================================="
            exit 1
            ;;
        n)
            echo "Setting board name..."
            BOARD_NAME="$OPTARG"
            ;;
        p)
            echo "Setting project name..."
            TOP_LVL_PROJECT_NAME="$OPTARG"
            ;;
        u)
            echo "Uploading after build..."
            UPLOAD=true
            ;;
        c)
            echo "Cleaning build dir first.."
            CLEAN=true
            ;;
        :)
            echo -e "Option flag required when passing in an argument. Stop."
            exit 1
            ;;
    esac
done

shift "$(($OPTIND -1))"

if [ "$CLEAN" = true ]; then

    rm -rf "$PWD/../build"

fi

echo "====== BUILD DIALOGUE ====================================================================================="
echo "      !!! Building in $BUILD_DIRECTORY !!!                                                                 "
echo "      !!! Configured for $BUILD_TYPE   !!!                                                                 "
echo "==========================================================================================================="

# make our build directory and move into it
mkdir -p ${BUILD_DIRECTORY}
cd ${BUILD_DIRECTORY}

# cmake command line calls that define some build/install environment variables like install directory and if we want unit testing
cmake   -DCMAKE_BOILERPLATE_PATH=${CMAKE_BOILERPLATES} \
        -DCMAKE_INSTALL_PREFIX=${INSTALL_DIRECTORY} \
        -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
        -DPICO_BOARD=${BOARD_NAME} \
        -DTOP_LVL_PROJECT_NAME=${TOP_LVL_PROJECT_NAME} \
        ..
cmake --build . -j 8
cmake --install .

cd ${SCRIPT_DIRECTORY}
if [ "$UPLOAD" = true ]; then

    BINARY_DIRECTORY=${INSTALL_DIRECTORY}/bin/

    ./upload.sh -b ${TOP_LVL_PROJECT_NAME}
fi
