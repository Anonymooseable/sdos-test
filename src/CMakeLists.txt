cmake_minimum_required(VERSION 2.8)
project(Sauerbraten CXX C)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/Modules)

# TODO what about other compilers? Can sauer be compiled with VC at all? anyway...
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++0x -fno-exceptions -fno-rtti -ffast-math")
endif()

find_package(SDL2 REQUIRED)
include_directories(${SDL2_INCLUDE_DIR})

find_package(SDL2_mixer REQUIRED)
# And again
#include_directories(${SDLMIXER_INCLUDE_DIR})

find_package(SDL2_image REQUIRED)
# Include seems not to be necessary, apparently the headers know where to find it already
#include_directories(${SDL2_IMAGE_INCLUDE_DIRS})

find_package(OpenGL REQUIRED)
#include_directories(${OPENGL_INCLUDE_DIR})

find_package(ZLIB REQUIRED)
#include_directories(${ZLIB_INCLUDE_DIRS})



add_subdirectory(deps/src/libenet)
include_directories(${ENET_INCLUDE_DIR})
add_subdirectory(shared)
include_directories(shared)
add_subdirectory(engine)

file(GLOB_RECURSE fpsgame_SOURCES fpsgame/*.cpp fpsgame/*.h)
if(APPLE)
    list(APPEND fpsgame_SOURCES ../xcode/main.m ../xcode/Launcher.m)
    set_source_files_properties(../xcode/main.m ../xcode/Launcher.m PROPERTIES LANGUAGE C)
endif(APPLE)
add_executable(Sauerbraten ${fpsgame_SOURCES})
target_link_libraries(Sauerbraten engine shared enet ${SDL2_LIBRARY} ${SDLMIXER_LIBRARY} ${SDL2_IMAGE_LIBRARIES} ${OPENGL_gl_LIBRARY} ${ZLIB_LIBRARIES})