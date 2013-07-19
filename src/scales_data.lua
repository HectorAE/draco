-- Standard data package for Scales
-- Coded by Hector Escobedo

require "scales_taxa"

local breathtable = {
   [1] = "fire",
   [2] = "ice",
   [3] = "acid",
}

local clawtable = {
   [1] = 3,
   [2] = 4,
   [3] = 5,
}

local colortable = {
   [1] = "red",
   [2] = "orange",
   [3] = "yellow",
   [4] = "green",
   [5] = "blue",
   [6] = "indigo",
   [7] = "violet",
   [8] = "brown",
   [9] = "black",
   [10] = "white",
   [11] = "grey",
}

local patterntable = {
   [1] = "solid",
   [2] = "mottled",
   [3] = "striped",
}

local sextable = {		-- Rather silly but useful
   [1] = "female",
   [2] = "male",
}

local P = {			-- Our package table to export
   breathtable = breathtable,	-- Pub name = local name
   clawtable = clawtable,
   colortable = colortable,
   patterntable = patterntable,
   sextable = sextable,
   species = scales_taxa.species,
}

-- Dynamic package name allocation for requires
-- Allocates the called filename to package

if _REQUIREDNAME == nil then
   scales_data = P			-- Default package name
else
   _G[_REQUIREDNAME] = P
end
