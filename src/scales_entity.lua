-- Base class definition for on-screen objects
-- Coded by Hector Escobedo

require "scales"

local entity = scales.new_class()

entity.sprite = nil

-- Takes an image file as a sprite
function entity:load_sprite (file)
   self.sprite = love.graphics.newImage(file)
end

-- Takes a preexisting image object as a sprite
function entity:change_sprite (image)
   self.sprite = image
end

-- Complete function for rendering the sprite on-screen
function entity:render ()
   love.graphics.draw(self.sprite, self.x, self.y)
end

entity.x = nil
entity.y = nil

local P = {			-- Our package table to export
   entity = entity,		-- Pub name = local name
}

-- Dynamic package name allocation for requires
-- Allocates the called filename to package

if _REQUIREDNAME == nil then
   scales_entity = P			-- Default package name
else
   _G[_REQUIREDNAME] = P
end
