#! /usr/bin/env lua

-- Main executable for Draco
-- Coded by Hector Escobedo

require "draco"
require "draco_ui"
require "draco_data"

local dragon = draco.gendragon()	-- Constructor for the table of attributes for the player's dragon

dragon.name = "Neirada"

local idprint = dragon.name .. " is a " .. dragon.sex .. " " .. dragon.breathtype .. " dragon."

-- print(idprint)

function love.draw ()
   love.graphics.printf(idprint, 0, 400, 800, "center")
end

function love.update (tick)
   if draco_ui.ctrlk("q") then
      love.event.push("quit")
   end
end
