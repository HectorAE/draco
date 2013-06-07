#! /usr/bin/env lua

-- Main executable for Draco
-- Coded by Hector Escobedo

require "draco"

dragon = draco.gendragon() 			-- Constructor for the table of attributes for the player's dragon

dragon.name = "Neirada"

idprint = dragon.name .. " is a " .. dragon.sex .. " " .. dragon.breathtype .. " dragon."

print(idprint)
