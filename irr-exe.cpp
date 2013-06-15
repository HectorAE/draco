#include <irrlicht.h>
// #include <luabind/luabind.hpp>

using namespace irr;

using namespace core;
using namespace scene;
using namespace video;
using namespace io;
using namespace gui;

// using namespace luabind;

int main()
{
  // Start the Irrlicht engine
  IrrlichtDevice *device =
    createDevice( video::EDT_OPENGL, dimension2d<u32>(200, 350), 16,
		  false, false, false, 0);
  if (!device)
    return 1;

  device->setWindowCaption(L"Draco");
  IVideoDriver* driver = device->getVideoDriver();
  ISceneManager* smgr = device->getSceneManager();
  IGUIEnvironment* guienv = device->getGUIEnvironment();

  guienv->addStaticText(L"This is Draco, a label.",
			rect<s32>(10,10,240,24), true);

  while(device->run())
    {
      driver->beginScene(true, true, SColor(244,100,101,130));
      smgr->drawAll();
      guienv->drawAll();
      driver->endScene();
    }

  device->drop();
  return 0;
}

// module(L)
// [
//  class_<dracoMainWindow>("topwindow")
// ]
