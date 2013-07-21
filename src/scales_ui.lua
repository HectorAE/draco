-- Package that contains lookup tables and functions for player control
-- Coded by Hector Escobedo

-- Virtual camera object which controls the view
-- Anything drawn between the apply and clear functions is transformed
-- by the virtual camera. Anything drawn outside stays absolute.
local vcam = {}
vcam.x = 0
vcam.y = 0
vcam.scale = 1
vcam.angle = 0
vcam.width = love.graphics.getWidth()
vcam.height = love.graphics.getHeight()

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
   self.scale = self.scale * s
   local sdiff = (1 - s)
   self:pan((self.width / 2) * sdiff, (self.height / 2) * sdiff)
   -- Only update height and width _after_ the centering pan
   self.width = (love.graphics.getWidth() * self.scale)
   self.height = (love.graphics.getHeight() * self.scale)
end

function vcam:setzoom (z)
   self:zoom(z / self.scale)
end

function vcam:apply ()
   love.graphics.push()
   love.graphics.scale(1 / self.scale)
   love.graphics.translate(-self.x, -self.y)
   love.graphics.rotate(-self.angle)
end

function vcam:clear ()
   love.graphics.pop()
end

-- Constructor function for new vcams
function vcam:new (x, y, s, a)
   local newcam = {}
   setmetatable(newcam, self)
   self.__index = self

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

local P = {			-- Our package table to export
   ctrlk = ctrlk,	-- Pub name = local name
   vcam = vcam,
}

-- Dynamic package name allocation for requires
-- Allocates the called filename to package

if _REQUIREDNAME == nil then
   scales_ui = P		-- Default package name
else
   _G[_REQUIREDNAME] = P
end
