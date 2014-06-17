file(GLOB_RECURSE shared_SOURCES *.cpp *.h)

if(APPLE)
    list(APPEND shared_SOURCES ../xcode/macutils.mm)
endif(APPLE)

add_library(shared STATIC ${shared_SOURCES})

if(APPLE)
endif(APPLE)