-- Globally accessible package that provides Draco's core functions
-- Coded by Hector Escobedo

local breathtable = {
   [1] = "fire",
   [2] = "ice",
   [3] = "acid",
}

local function randbreathtype ()
   math.randomseed(os.time())	-- Kludgy but workable
   local int = math.random(# breathtable) -- 1 to length of table
   return breathtable[int]
end

local function randsex ()
   math.randomseed(os.time())
   local int = math.random(2)
   if int == 1 then
      return "female"
   else
      return "male"
   end
end

local function gendragon ()	-- Main function for creating new dragons
   local attr = {
      ["breathtype"] = randbreathtype(),
      ["sex"] = randsex(),
   }
   return attr
end

local P = {			-- Our package table to export
   gendragon = gendragon,
}

-- Dynamic package name allocation for requires
-- Allocates the called filename to package

if _REQUIREDNAME == nil then
   draco = P			-- Default package name
else
   _G[_REQUIREDNAME] = P
end