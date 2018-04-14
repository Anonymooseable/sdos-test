file(GLOB enet_SOURCES *.c)
set(ENET_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include CACHE PATH "Path to enet includes")
include_directories(${ENET_INCLUDE_DIR})
add_library(enet STATIC ${enet_SOURCES})
