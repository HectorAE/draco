-- Globally accessible package that provides Draco's core functions
-- Coded by Hector Escobedo

local function gendragon ()
   local breathtype = "fire"
   return breathtype
end

local P = {			-- Our local package table
   gendragon = gendragon
}

-- Dynamic package name allocation for requires

if _REQUIREDNAME == nil then
   draco = P			-- Default package name
else
   _G[_REQUIREDNAME] = P
end