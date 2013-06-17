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

int main() {
  // // Start the Irrlicht engine
  // IrrlichtDevice *device =
  //   createDevice( video::EDT_OPENGL, dimension2d<u32>(200, 350), 16,
  // 		  false, false, false, 0);
  // if (!device)
  //   return 1;

  // Create our global Lua state
  lua_State *L = luaL_newstate();

  // Connect it to luabind
  luabind::open(L);

  // // device->setWindowCaption(L"Draco");
  // IVideoDriver* driver = device->getVideoDriver();
  // ISceneManager* smgr = device->getSceneManager();
  // IGUIEnvironment* guienv = device->getGUIEnvironment();

  // guienv->addStaticText(L"This is Draco, a label.",
  // 			rect<s32>(10,10,240,24), true);

  // while(device->run())
  //   {
  //     driver->beginScene(true, true, SColor(244,100,101,130));
  //     smgr->drawAll();
  //     guienv->drawAll();
  //     driver->endScene();
  //   }

  // Bind the engine to the Lua state's global scope
  luabind::module(L) [
		      // luabind::class_<IrrlichtDevice>("IrrlichtDevice")
		      luabind::def("createDevice", createDevice)
		      // luabind::def("E_DRIVER_TYPE", E_DRIVER_TYPE)
		      // luabind::def("dimension2d", dimension2d)
		      ];

  // Run the main Lua file
  luaL_dostring(
		L, "dofile('./draco-exe.lua')"
		);

  // device->drop();

  lua_close(L);
  return 0;
}
