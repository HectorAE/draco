-- Globally accessible package that provides Scales' core functions
-- Coded by Hector Escobedo

-- Don't try to generate dragons too fast until a better source of
-- entropy is found. All random parameters are identical during the
-- same second!

local function randselect (index)
   math.randomseed(os.time())
   local int = math.random(# index)
   return index[int]
end

-- Function that creates a "colorscheme table".
local function gencolorscheme (opt)
   if opt == nil then
      opt = {}
   end
   local pattern = opt.pattern or randselect(data.patterntable)
   if pattern == "solid" then
      return {
	 pattern = pattern,
	 maincolor = opt.maincolor or randselect(data.colortable),
	     }
   elseif pattern == "mottled" or "striped" then
      return {
	 pattern = pattern,
	 maincolor = opt.maincolor or randselect(data.colortable),
	 featurecolor = opt.featurecolor or randselect(data.colortable),
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
      opt = {}
   end
   opt.breathtype = opt.breathtype or randselect(data.breathtable)
   opt.sex = opt.sex or randselect(data.sextable)
   opt.colorscheme = gencolorscheme(opt.colorscheme)
   opt.claws = opt.claws or randselect(data.clawtable)
   return opt
end

-- Basic class constructor (single inheritance)
local function new_class (parent)
   local newc = {}
   if parent then
      setmetatable(newc, parent) -- Parent class should have __index
   end

   newc.__index = newc		-- Prepare to be looked up by children

   function newc:new ()
      local obj = {}
      setmetatable(obj, self)
      return obj
   end

   return newc
end

local state = nil

local P = {			-- Our package table to export
   gendragon = gendragon,	-- Pub name = local name
   new_class = new_class,
   state = state,
}

-- Dynamic package name allocation for requires
-- Allocates the called filename to package

if _REQUIREDNAME == nil then
   scales = P			-- Default package name
else
   _G[_REQUIREDNAME] = P
end
