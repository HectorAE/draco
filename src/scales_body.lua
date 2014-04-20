-- Provides more structure for complex collections of entities.
-- Coded by Hector Escobedo

local body = scales.new_class()

body.parts = {}
body.x = 0
body.y = 0
body.scale = 1
body.angle = 0

function body:pinparts ()
   for k,v in pairs(self.parts) do
      v.x = self.x + (v.xoffset * math.cos(self.angle))
	 - (v.yoffset * math.sin(self.angle))
      v.y = self.y + (v.yoffset * math.cos(self.angle))
	 + (v.xoffset * math.sin(self.angle))
   end
end

function body:render ()
   self:pinparts()
   for k,v in pairs(self.parts) do
      v:render()
   end
end

function body:fade (s, duration)
   for k,v in pairs(self.parts) do
      v:fade(s, duration)
   end
end

function body:forward (px)
   self.y = self.y - (math.cos(self.angle) * px)
   self.x = self.x + (math.sin(self.angle) * px)
end

function body:backward (px)
   self.y = self.y + (math.cos(self.angle) * px)
   self.x = self.x - (math.sin(self.angle) * px)
end

function body:rotate (d)
   self.angle = self.angle + d
   for k,v in pairs(self.parts) do
      v.angle = self.angle
   end
end

-- Package export table
local P = {
   body = body,
}

-- Dynamic package name allocation for requires
-- Allocates the called filename to package

if _REQUIREDNAME == nil then
   scales_body = P		-- Default package name
else
   _G[_REQUIREDNAME] = P
end
