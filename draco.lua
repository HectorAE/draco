-- Globally accessible package that provides Draco's core functions
-- Coded by Hector Escobedo

-- Don't try to generate dragons too fast until a better source of
-- entropy is found. All random parameters are identical during the
-- same second!

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

local sextable = {		-- Rather silly but useful
   [1] = "female",
   [2] = "male",
}

local function randsex ()
   math.randomseed(os.time())
   local int = math.random(# sextable)
   return sextable[int]
end

-- Function that checks a dragon's attributes are all good with
-- the standard trait lists.
local function valdragon (attr)
   return true 			-- Heck, it's all the same to me.
end

-- Main function for creating new dragons
-- Takes a single indexed table (opt) with optional parameters for
-- generation. All missing params (== nil) are randomized. This is
-- one instance where or shortcut eval is very useful. Returns the
-- final attribute table.
local function gendragon (opt)
   if opt == nil then
      opt = {}			-- Still in local function, safe
   end
   local attr = {
      breathtype = opt.breathtype or randbreathtype(),
      sex = opt.sex or randsex(),
   }
   return attr
end

local P = {			-- Our package table to export
   gendragon = gendragon,	-- Pub name = local name
}

-- Dynamic package name allocation for requires
-- Allocates the called filename to package

if _REQUIREDNAME == nil then
   draco = P			-- Default package name
else
   _G[_REQUIREDNAME] = P
end