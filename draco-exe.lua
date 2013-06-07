#! /usr/bin/env lua

-- Main executable for Draco
-- Coded by Hector Escobedo

local draco = require "draco"
local lgi = require "lgi"
local Gtk = lgi.Gtk

local dragon = draco.gendragon() 			-- Constructor for the table of attributes for the player's dragon

dragon.name = "Neirada"

local idprint = dragon.name .. " is a " .. dragon.sex .. " " .. dragon.breathtype .. " dragon."

print(idprint)

local topwindow = Gtk.Window()
topwindow.title = "Draco"
function topwindow:on_destroy ()
   Gtk.main_quit()
end
topwindow:show_all()
Gtk.main()