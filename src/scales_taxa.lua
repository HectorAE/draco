-- Taxonomic class system for Scales
-- Coded by Hector Escobedo

local taxaranktable = {
   [1] = "domain",
   [2] = "kingdom",
   [3] = "phylum",
   [4] = "class",
   [5] = "order",
   [6] = "family",
   [7] = "genus",
   [8] = "species",
}

local trt = taxaranktable

local taxon = {}		-- The taxon toolkit

-- Function for defining new taxa classes
function taxon:define (parent)
   t = {}
   if parent == nil then
      t.rankno = 1		-- Root taxon
   else
      setmetatable(t, {__index = parent})
      if parent.rankno < 8 then
	 t.rankno = parent.rankno + 1
      else
	 error("tried to define a subspecies taxon", 2) -- Not me! Them!
      end
   end

   t.rank = trt[t.rankno]

   return t
end

-- Taxonomic class tree
local eukaryota = taxon:define()

local animalia = taxon:define(eukaryota)
animalia.arms = 0
animalia.legs = 0
animalia.wings = 0

local chordata = taxon:define(animalia)

local mammalia = taxon:define(chordata)

local primates = taxon:define(mammalia)
primates.arms = 2
primates.legs = 2

local hominidae = taxon:define(primates)

local homo = taxon:define(hominidae)

local homo_sapiens = taxon:define(homo)

local pan = taxon:define(hominidae)

local pan_troglodytes = taxon:define(pan)

local carnivora = taxon:define(mammalia)

local canidae = taxon:define(carnivora)

local canis = taxon:define(canidae)

local canis_lupus = taxon:define(canis)

-- The public species table, a simplified interface
local species = {
   homo_sapiens = homo_sapiens,
   pan_troglodytes = pan_troglodytes,
   canis_lupus = canis_lupus,
}

local P = {			-- Our package table to export
   species = species,		-- Pub name = local name
   taxaranktable = taxaranktable,
   taxon = taxon,
}

-- Dynamic package name allocation for requires
-- Allocates the called filename to package

if _REQUIREDNAME == nil then
   scales_taxa = P			-- Default package name
else
   _G[_REQUIREDNAME] = P
end
