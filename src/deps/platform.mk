DEPSDIR:= $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
PREFIX:= $(shell $(DEPSDIR)/config.guess)
ARCHFLAGS:= -I$(DEPSDIR)/$(PREFIX)/include
OPTFLAGS:= -ffast-math -O3 -fomit-frame-pointer -fvisibility=hidden
STRIP:= strip

ifneq (, $(findstring mingw,$(PREFIX)))
WINDOWS:= 1
CXX:= $(PREFIX)-g++
CC:= $(PREFIX)-gcc
WINDRES:= $(PREFIX)-windres
ifneq (, $(STRIP))
STRIP:= x86_64-w64-mingw32-strip
endif
ARCHFLAGS+= -pthread -I$(DEPSDIR)/extra/xaudio2

else ifneq (, $(findstring linux,$(PREFIX)))
LINUX:= 1
ARCHFLAGS+= -pthread

else ifneq (, $(findstring darwin,$(PREFIX)))
CXX:= clang++
CC:= clang
ARCHFLAGS+= -mmacosx-version-min=10.5
MAC:= 1

else
$(error Unknown architecture $(PREFIX))
endif


ifneq (, $(findstring x86_64,$(PREFIX)))
ARCHFLAGS+= -m64 
else
ARCHFLAGS+= -m32 
endif


export CC
export CXX
export CPPFLAGS:= $(ARCHFLAGS) $(OPTFLAGS)
export CFLAGS:= $(ARCHFLAGS) $(OPTFLAGS)
export LDFLAGS:= $(ARCHFLAGS) $(OPTFLAGS) -L$(DEPSDIR)/$(PREFIX)/lib
export CXXFLAGS:= $(ARCHFLAGS) $(OPTFLAGS) -fvisibility-inlines-hidden
export PKG_CONFIG_LIBDIR:= $(DEPSDIR)/$(PREFIX)/lib/pkgconfig
export PATH:= $(DEPSDIR)/$(PREFIX)/bin:$(PATH)

