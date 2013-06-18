#! /usr/bin/env lua

-- Main executable for Draco
-- Coded by Hector Escobedo

require "draco"

draco.getdata()

local dragon = draco.gendragon()	-- Constructor for the table of attributes for the player's dragon

dragon.name = "Neirada"

local idprint = dragon.name .. " is a " .. dragon.sex .. " " .. dragon.breathtype .. " dragon."

print(idprint)

-- device = createDevice(E_DRIVER_TYPE.EDT_OPENGL, dimension2d(400, 100), 16, false, false, false, 0)

-- device.setWindowCaption("Draco")

-- guienv.addStaticText(L"This is Draco, a label.",
-- 		     rect<s32>(10,10,240,24), true)

-- while device.run() do
--    driver.beginScene(true, true, SColor(244,100,101,130))
--    smgr.drawAll()
--    guienv.drawAll()
--    driver.endScene()
-- end

-- device.run()
