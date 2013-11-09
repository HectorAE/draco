-- Base class definition for on-screen objects
-- Coded by Hector Escobedo

require "scales"

local entity = scales.new_class()

entity.sprite = nil

-- Takes an image file as a sprite
function entity:load_sprite (file)
   self.sprite = love.graphics.newImage(file)
   self.width = self.sprite:getWidth()
   self.height = self.sprite:getHeight()
end

-- Takes a preexisting image object as a sprite
function entity:change_sprite (image)
   self.sprite = image
   self.width = self.sprite:getWidth()
   self.height = self.sprite:getHeight()
end

-- Complete function for rendering the sprite on-screen
function entity:render ()
   love.graphics.draw(self.sprite, self.x, self.y, self.angle, self.scale, self.scale, (self.width / 2), (self.height / 2))
end

entity.x = 0
entity.y = 0
entity.scale = 1
entity.angle = 0
entity.width = nil
entity.height = nil

function entity:forward (px)
   self.y = self.y - (math.cos(self.angle) * 10)
   self.x = self.x + (math.sin(self.angle) * 10)
end

function entity:backward (px)
   self.y = self.y + (math.cos(self.angle) * 10)
   self.x = self.x - (math.sin(self.angle) * 10)
end

local clickable = scales.new_class(entity)

clickable.onclick = nil

function clickable:check ()
   if love.mouse.getX() >= (self.x - (self.width / 2)) and love.mouse.getX() <= (self.x + (self.width / 2)) and love.mouse.getY() >= (self.y - (self.height / 2)) and love.mouse.getY() <= (self.y + (self.height / 2)) then
      -- self.onhover()
      if love.mouse.isDown("l") then
	 self.onclick()
	 return true
      end
   end
end

local P = {			-- Our package table to export
   entity = entity,		-- Pub name = local name
   clickable = clickable,
}

-- Dynamic package name allocation for requires
-- Allocates the called filename to package

if _REQUIREDNAME == nil then
   scales_entity = P			-- Default package name
else
   _G[_REQUIREDNAME] = P
end
