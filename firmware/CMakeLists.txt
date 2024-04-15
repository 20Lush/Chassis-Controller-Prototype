cmake_minimum_required(VERSION 3.22)

# Define what source files we actually are going to compile
set(SOURCE_FILES
    src/main.cpp
)

# Do a CMake add_executable to mark it for build
add_executable( ${PROJECT_NAME}
    ${SOURCE_FILES}
)

# There might be some includes we want at build-time here
include_directories("${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}")

# The installed directory is going to have its own include directory.
# In the unlikely scenario this executable is used in another project,
# they'll need the public headers.
target_include_directories(${PROJECT_NAME}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
)

# Put any compile features we'd want in here, like language standards
target_compile_features(${PROJECT_NAME}
    PUBLIC
)

# Set some target properties of the installed binaries, liked if they have position independent code

# Link the libraries we want, like OpenCV or the cuda toolkit
target_link_libraries(${PROJECT_NAME}
    # any dependency library we are linking...
    pico_stdlib
)

# Send to boilerplate!
message(STATUS "Deploying USB pico-sdk project...")

pico_enable_stdio_usb(${PROJECT_NAME} 1)
pico_enable_stdio_uart(${PROJECT_NAME} 0)

pico_add_extra_outputs(${PROJECT_NAME})