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

function vcam:pan (px, py)
   self.x = self.x + (px or 0)
   self.y = self.y + (py or 0)
end

function vcam:adjpan(px, py)
   self.x = self.x + ((px * self.scale) or 0)
   self.y = self.y + ((py * self.scale) or 0)
end

function vcam:rotate (d)
   self.angle = self.angle + d
end

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

function vcam:zoom (s)
   self.scale = self.scale * s
   local sdiff = (1 - s)
   self:pan((self.width / 2) * sdiff, (self.height / 2) * sdiff)
   self.width = (love.graphics.getWidth() * self.scale)
   self.height = (love.graphics.getHeight() * self.scale)
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
