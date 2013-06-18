#include <iostream>
#include <irrlicht.h>

extern "C" {
#include <lua5.1/lua.h>
#include <lua5.1/lauxlib.h>
#include <lua5.1/lualib.h>
}

#include <luabind/luabind.hpp>

using namespace irr;

using namespace core;
using namespace scene;
using namespace video;
using namespace io;
using namespace gui;

// using namespace luabind;

void stringout(const char* instr) {
  std::cout << instr << std::endl;
}

int main() {
  // Create our global Lua state
  lua_State *L = luaL_newstate();

  // Connect it to luabind
  luabind::open(L);

  // Bind the engine to the Lua state's global scope
  luabind::module(L) [
		      luabind::def("createDevice", createDevice),
		      luabind::class_<dimension2d <u32> >("dimension2d"),
		      luabind::def("cout", stringout)
		      ];

  luaL_dostring(
		L, "cout('Draco started.')"
		);

  // Run the main Lua file
  // luaL_dostring(
  // 		L, "dofile('./draco-exe.lua')"
  // 		);

  // device->drop();

  lua_close(L);
  return 0;
}
