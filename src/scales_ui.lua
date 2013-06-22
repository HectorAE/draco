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

function vcam:zoom (s)
   self.scale = self.scale * s
end

function vcam:pan (px, py)
   self.x = self.x + (px or 0)
   self.y = self.y + (py or 0)
end

function vcam:rotate (d)
   self.angle = self.angle + d
end

function vcam:setpos (px, py)
   self.x = px or self.x
   self.y = py or self.y
end

-- Take two coordinates and center them to the window and scale
function vcam:posadjust (px, py)
   local realx = px - ((love.graphics.getWidth() / 2) * self.scale)
   local realy = py - ((love.graphics.getHeight() / 2) * self.scale)
   return realx, realy
end

function vcam:apply ()
   love.graphics.push()
   love.graphics.rotate(-self.angle)
   love.graphics.scale(1 / self.scale)
   love.graphics.translate(-self.x, -self.y)
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
