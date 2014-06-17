file(GLOB_RECURSE engine_SOURCES *.cpp *.h)
add_library(engine STATIC ${engine_SOURCES})
