# Automake generator file for Draco

bin_PROGRAMS = draco-irr
draco_irr_SOURCES = irr-exe.cpp

# Bit kludgy, but eh
AM_CXXFLAGS = -I$(includedir)/irrlicht/
AM_LDFLAGS =  -lIrrlicht -llua5.1 -lluabind

doc_DATA = README.md
