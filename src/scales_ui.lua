-- Package that contains lookup tables and functions for player control
-- Coded by Hector Escobedo

require "scales"

-- Virtual camera object which controls the view
-- Anything drawn between the apply and clear functions is transformed
-- by the virtual camera. Anything drawn outside stays absolute.
local vcam = scales.new_class()
vcam.x = 0
vcam.y = 0
vcam.scale = 1
vcam.angle = 0
vcam.width = love.graphics.getWidth()
vcam.height = love.graphics.getHeight()

-- The bounding box
vcam.lbound = 0
vcam.rbound = love.graphics.getWidth()
vcam.ubound = 0
vcam.dbound = love.graphics.getHeight()

-- Zoom limits
vcam.inlimit = .25
vcam.outlimit = 1

-- Panning function, in absolute terms
function vcam:pan (px, py)
   self.x = self.x + (px or 0)
   self.y = self.y + (py or 0)
end

-- Adjusted panning function, which factors in zoom
function vcam:adjpan(px, py)
   self.x = self.x + ((px * self.scale) or 0)
   self.y = self.y + ((py * self.scale) or 0)
end

-- Rotation function
function vcam:rotate (d)
   self.angle = self.angle + d
end

-- Function to set the absolute position
function vcam:setpos (px, py)
   self.x = px or self.x
   self.y = py or self.y
end

-- Take two coordinates and center them to the window
function vcam:posadjust (px, py)
   local realx = px - (self.width / 2)
   local realy = py - (self.height / 2)
   return realx, realy
end

-- Centered zoom function, took forever to get right
function vcam:zoom (s)
   local cs = self:checkzoom(s)
   self.scale = self.scale * cs
   local sdiff = (1 - cs)
   self:pan((self.width / 2) * sdiff, (self.height / 2) * sdiff)
   -- Only update height and width _after_ the centering pan
   self.width = (love.graphics.getWidth() * self.scale)
   self.height = (love.graphics.getHeight() * self.scale)
end

function vcam:setzoom (z)
   self:zoom(z / self.scale)
end

-- Helper function to correct out-of-bounds zooms
function vcam:checkzoom (s)
   -- This correction shouldn't happen very often
   if self.scale > self.outlimit then
      self.scale = self.outlimit
      return 1
   elseif self.scale < self.inlimit then
      self.scale = self.inlimit
      return 1
   end

   -- If we're going to overshoot then just set to the limit
   if self.scale * s > self.outlimit then
      return self.outlimit / self.scale
   elseif self.scale * s < self.inlimit then
      return self.inlimit / self.scale
   end

   return s
end

-- Handy function to anchor the view within a box
function vcam:checkbounds ()
   if self.x < self.lbound then
      self.x = self.lbound
   elseif (self.x + self.width) > self.rbound then
      self.x = (self.rbound - self.width)
   end

   if self.y < self.ubound then
      self.y = self.ubound
   elseif (self.y + self.height) > self.dbound then
      self.y = (self.dbound - self.height)
   end
end

function vcam:apply ()
   self:checkbounds()		-- Obey the boundaries

   love.graphics.push()
   love.graphics.scale(1 / self.scale)
   love.graphics.translate(-self.x, -self.y)
   love.graphics.rotate(-self.angle)
end

function vcam:clear ()
   love.graphics.pop()
end

-- Special constructor function for new vcams
function vcam:new (x, y, s, a)
   local newcam = {}
   setmetatable(newcam, self)

   newcam.x = x or self.x
   newcam.y = y or self.y
   newcam.scale = s or self.scale
   newcam.angle = a or self.angle
   newcam.width = love.graphics.getWidth() * newcam.scale
   newcam.height = love.graphics.getHeight() * newcam.scale

   return newcam
end

-- Checks if the CTRL is being held down with another key
local function ctrlk (k)
   if love.keyboard.isDown(k) and love.keyboard.isDown("rctrl", "lctrl") then
      return true
   else
      return false
   end
end

-- A screen is a just collection of entities
local screen = scales.new_class()

function screen:render ()
   for e=1,#self do
      self[e]:render()
   end
end

-- Function that fades an entity by tiny increments
local function fade (ent, rate)
   love.timer.sleep(1 / 300)
   if ent.alpha > 0 then
      if rate <= ent.alpha then
	 ent.alpha = ent.alpha - rate
      else
	 ent.alpha = 0
      end
      return 0
   else
      return 1
   end
end

local P = {			-- Our package table to export
   ctrlk = ctrlk,	-- Pub name = local name
   vcam = vcam,
   screen = screen,
   fade = fade,
}

-- Dynamic package name allocation for requires
-- Allocates the called filename to package

if _REQUIREDNAME == nil then
   scales_ui = P		-- Default package name
else
   _G[_REQUIREDNAME] = P
end
