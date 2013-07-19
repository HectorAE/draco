-- Mapper functions and topographical data for Scales
-- Coded by Hector Escobedo

-- Table that contains all in-game entities
local world = {}

-- Numeric index of tiles
world.tileindex = {
   [1] = "sand",
   [2] = "water",
}

-- Each level is associated with a map
world.levels = {
   [1] = {
      {2, 1, 1, 2, 2, 1, 2, 2, 2, 1, 2, 1, 1, 1},
      {2, 2, 1, 2, 2, 1, 2, 2, 2, 1, 2, 2, 2, 1},
      {2, 2, 2, 2, 2, 1, 2, 2, 2, 1, 2, 1, 1, 1},
      {2, 1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1},
      {2, 1, 1, 2, 2, 1, 2, 2, 2, 2, 2, 1, 1, 1},
      {2, 1, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1},
      {2, 1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 1, 1, 1},
      {2, 1, 1, 2, 2, 1, 2, 2, 2, 1, 2, 2, 2, 1},
      {2, 1, 1, 2, 2, 1, 2, 2, 2, 2, 2, 1, 1, 1},
      {2, 1, 1, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 1},
      x = 0,
      y = 0,
   }
}

-- Load images from a directory into the image object container
local function loadtiles (dir, index, creator, container)
   for k, i in ipairs(index) do
      container[k] = creator(dir .. "/" .. i .. ".png")
   end
end

-- Generalized map drawing function
-- WARNING: Only works with rectangular maps
local function mapdraw (map, tileset, tilesize, drawer)
   for y=1, (#map - map.y) do
      for x=1, (#map[y] - map.x) do
	 drawer(
	    tileset[map[y+map.y][x+map.x]],
	    (x*tilesize),
	    (y*tilesize))
      end
   end
end

local P = {			-- Our package table to export
   world = world,		-- Pub name = local name
   mapdraw = mapdraw,
   loadtiles = loadtiles,
}

-- Dynamic package name allocation for requires
-- Allocates the called filename to package

if _REQUIREDNAME == nil then
   scales_mapper = P			-- Default package name
else
   _G[_REQUIREDNAME] = P
end