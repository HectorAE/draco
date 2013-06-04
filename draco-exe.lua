#! /usr/bin/env lua

-- Main module for Draco
-- Coded by Hector Escobedo

dragon = {} 			-- Constructor for the table of attributes for the player's dragon

dragon["name"] = "Neirada"
dragon["sex"] = "female"
dragon["type"] = "fire"

idprint = dragon["name"] .. " is a " .. dragon["sex"] .. " " .. dragon["type"] .. " dragon."

print(idprint)