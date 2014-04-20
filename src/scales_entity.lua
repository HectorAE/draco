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
   love.graphics.setColor(255, 255, 255, self.alpha)
   love.graphics.draw(self.sprite, self.x, self.y, self.angle, self.scale, self.scale, (self.width / 2), (self.height / 2))
   love.graphics.setColor(255, 255, 255, 255)
end

-- Function that fades an entity by increments, measuring
-- the time in seconds since the last call
function entity:fade (s, duration)
   tofade = math.ceil(s / duration * 255)
   if self.alpha > 0 then
      if tofade <= self.alpha then
	 self.alpha = self.alpha - tofade
      else
	 self.alpha = 0
      end
   end
end

entity.x = 0
entity.y = 0
entity.scale = 1
entity.angle = 0
entity.width = nil
entity.height = nil
entity.alpha = 255

function entity:forward (px)
   self.y = self.y - (math.cos(self.angle) * px)
   self.x = self.x + (math.sin(self.angle) * px)
end

function entity:backward (px)
   self.y = self.y + (math.cos(self.angle) * px)
   self.x = self.x - (math.sin(self.angle) * px)
end

function entity:rotate (d)
   self.angle = self.angle + d
end

-- A clickable is an entity that can be clicked
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

-- A screen is a just collection of entities
local screen = scales.new_class()

-- Create N new entities in the screen
function screen:init (n)
   for c=1,n do
      self[c] = entity:new()
   end
end

-- Call a method for every entity in the screen; explicitly
-- pass it its own value
function screen:methodcall (method, ...)
   for k,v in pairs(self) do
      self[k][method](v, ...)
   end
end

-- Call a function for every entity in the screen
function screen:functioncall (func, ...)
   for k,v in pairs(self) do
      self[k][func](...)
   end
end

-- Set a variable or member for every entity in the screen
function screen:setattr (attr, value)
   for k,v in pairs(self) do
      self[k][attr] = value
   end
end

local P = {			-- Our package table to export
   entity = entity,		-- Pub name = local name
   clickable = clickable,
   screen = screen,
}

-- Dynamic package name allocation for requires
-- Allocates the called filename to package

if _REQUIREDNAME == nil then
   scales_entity = P			-- Default package name
else
   _G[_REQUIREDNAME] = P
end
