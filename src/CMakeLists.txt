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

include_directories(shared)

list(APPEND Sauerbraten_SOURCES
    shared/crypto.cpp
    shared/geom.cpp
    shared/stream.cpp
    shared/tools.cpp
    shared/zip.cpp
    engine/3dgui.cpp
    engine/bih.cpp
    engine/blend.cpp
    engine/blob.cpp
    engine/client.cpp
    engine/command.cpp
    engine/console.cpp
    engine/cubeloader.cpp
    engine/decal.cpp
    engine/dynlight.cpp
    engine/glare.cpp
    engine/grass.cpp
    engine/lightmap.cpp
    engine/main.cpp
    engine/material.cpp
    engine/menus.cpp
    engine/movie.cpp
    engine/normal.cpp
    engine/octa.cpp
    engine/octaedit.cpp
    engine/octarender.cpp
    engine/physics.cpp
    engine/pvs.cpp
    engine/rendergl.cpp
    engine/rendermodel.cpp
    engine/renderparticles.cpp
    engine/rendersky.cpp
    engine/rendertext.cpp
    engine/renderva.cpp
    engine/server.cpp
    engine/serverbrowser.cpp
    engine/shader.cpp
    engine/shadowmap.cpp
    engine/sound.cpp
    engine/texture.cpp
    engine/water.cpp
    engine/world.cpp
    engine/worldio.cpp
    fpsgame/ai.cpp
    fpsgame/client.cpp
    fpsgame/entities.cpp
    fpsgame/fps.cpp
    fpsgame/monster.cpp
    fpsgame/movable.cpp
    fpsgame/render.cpp
    fpsgame/scoreboard.cpp
    fpsgame/server.cpp
    fpsgame/waypoint.cpp
    fpsgame/weapon.cpp
)
if(APPLE)
    list(APPEND Sauerbraten_SOURCES xcode/main.m xcode/Launcher.m xcode/macutils.mm)
    set_source_files_properties(xcode/main.m xcode/Launcher.m PROPERTIES LANGUAGE C)
endif(APPLE)
add_executable(Sauerbraten ${Sauerbraten_SOURCES})
target_link_libraries(Sauerbraten enet ${SDL2_LIBRARY} ${SDLMIXER_LIBRARY} ${SDL2_IMAGE_LIBRARIES} ${OPENGL_gl_LIBRARY} ${ZLIB_LIBRARIES})