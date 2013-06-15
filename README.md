Draco
=====

**Draco** is an interactive dragon experience. Exult in the sheer 
elemental power of your ancient bloodline. Don't play a dragon, _be_ a 
dragon. In this world, there is little to nothing holding you back from 
doing whatever you see fit.

This game is still in development. It is considered unstable and not
yet ready for distribution.

Build and Install
-----------------

Use the provided GNU Autotools scripts to configure and build the 
compiled parts of the program.

1. $ autoreconf --install
2. $ ./configure --prefix /usr # So library links work correctly
3. $ make
4. $ sudo make install

You must have the Irrlicht 3D Engine library installed to compile the 
main program.
