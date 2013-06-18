-- Globally accessible package that provides Draco's core functions
-- Coded by Hector Escobedo

-- Don't try to generate dragons too fast until a better source of
-- entropy is found. All random parameters are identical during the
-- same second!

local function getdata (file)	-- Loads data tables
   if file == nil then
      file = "draco_data.lua"			-- Still in local function, safe
   end
   dofile(file)
end

local function randselect (index)
   math.randomseed(os.time())
   local int = math.random(# index)
   return index[int]
end

-- Function that creates a "colorscheme table".
local function gencolorscheme (opt)
   if opt == nil then
      opt = {}			-- Still in local function, safe
   end
   local pattern = opt.pattern or randselect(patterntable)
   if pattern == "solid" then
      return {
	 pattern = pattern,
	 maincolor = opt.maincolor or randselect(colortable),
	     }
   elseif pattern == "mottled" or "striped" then
      return {
	 pattern = pattern,
	 maincolor = opt.maincolor or randselect(colortable),
	 featurecolor = opt.featurecolor or randselect(colortable),
	     }
   else
      error("invalid pattern string", 3) -- Point at gendragon caller
   end
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
-- final attribute table for initializing a dragon object.
local function gendragon (opt)
   if opt == nil then
      opt = {}			-- Still in local function, safe
   end
   local attr = {
      breathtype = opt.breathtype or randselect(breathtable),
      sex = opt.sex or randselect(sextable),
      colorscheme = gencolorscheme(opt.colorscheme),
      claws = opt.claws or randselect(clawtable),
   }
   return attr
end

local P = {			-- Our package table to export
   gendragon = gendragon,	-- Pub name = local name
   getdata = getdata,
}

-- Dynamic package name allocation for requires
-- Allocates the called filename to package

if _REQUIREDNAME == nil then
   draco = P			-- Default package name
else
   _G[_REQUIREDNAME] = P
end
