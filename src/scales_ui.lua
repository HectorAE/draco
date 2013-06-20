-- Package that contains lookup tables and functions for player control
-- Coded by Hector Escobedo

local function ctrlk (k)
   if love.keyboard.isDown(k) and love.keyboard.isDown("rctrl", "lctrl") then
      return true
   else
      return false
   end
end

local P = {			-- Our package table to export
   ctrlk = ctrlk,	-- Pub name = local name
}

-- Dynamic package name allocation for requires
-- Allocates the called filename to package

if _REQUIREDNAME == nil then
   scales_ui = P		-- Default package name
else
   _G[_REQUIREDNAME] = P
end
