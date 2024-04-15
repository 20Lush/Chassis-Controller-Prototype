
# Important directories to keep track of
SCRIPT_DIR="$PWD"
BUILD_DIR="${SCRIPT_DIR}/../build"

# Default values for our binaries live (uf2)
BINARY="default_name"
BINARY_DIR="${BUILD_DIR}/firmware"

# Handle command line arguments
while getopts 'd:b:' opt; do
    case "$opt" in
        d)
            BINARY_DIR="$OPTARG"
            ;;
        b)
            BINARY="$OPTARG"
            ;;
        :)
            echo -e "Option flag required when passing in an argument. Stop."
            exit 1
            ;;
    esac
done

# Construct the path to our uf2 binary
UF2_BIN_DIR="${BINARY_DIR}/${BINARY}.uf2"

# Use picotool to force load the new binary
picotool load ${UF2_BIN_DIR} -f