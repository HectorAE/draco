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

local taxon = {}		-- The taxon base class toolkit

-- Function for defining new taxa classes
function taxon:define (parent)
   local nt = {}
   if parent == nil then
      setmetatable(nt, self)
      self.__index = self
      nt.rankno = 1		-- Root taxon
   else
      setmetatable(nt, {__index = parent})
      if parent.rankno < 8 then
	 nt.rankno = parent.rankno + 1
      else
	 error("tried to define a subspecies taxon", 2) -- Not me! Them!
      end
   end

   nt.rank = trt[nt.rankno]

   return nt
end

-- Taxonomic class tree
local eukaryota = taxon:define()
eukaryota.domain = "eukaryota"

local animalia = taxon:define(eukaryota)
animalia.kingdom = "animalia"

animalia.arms = 0
animalia.eyes = 2
animalia.fins = 0
animalia.legs = 0
animalia.wings = 0

local chordata = taxon:define(animalia)
chordata.phylum = "chordata"

local mammalia = taxon:define(chordata)
mammalia.class = "mammalia"

local primates = taxon:define(mammalia)
primates.order = "primates"

primates.arms = 2
primates.legs = 2

local hominidae = taxon:define(primates)
hominidae.family = "hominidae"

local homo = taxon:define(hominidae)
homo.genus = "homo"

local homo_sapiens = taxon:define(homo)
homo_sapiens.species = "sapiens"

homo_sapiens.name = {
   english = "human",
   english_pl = "humans",
}

local pan = taxon:define(hominidae)
pan.genus = "pan"

local pan_troglodytes = taxon:define(pan)
pan_troglodytes.species = "troglodytes"

pan_troglodytes.name = {
   english = "chimpanzee",
   english_pl = "chimpanzees",
}

local carnivora = taxon:define(mammalia)
carnivora.order = "carnivora"

local canidae = taxon:define(carnivora)
canidae.family = "canidae"

canidae.legs = 4

local canis = taxon:define(canidae)
canis.genus = "canis"

local canis_lupus = taxon:define(canis)
canis_lupus.species = "lupus"

canis_lupus.name = {
   english = "grey wolf",
   english_pl = "grey wolves",
}

-- The public species table, a simplified interface
local species = {
   homo_sapiens = homo_sapiens,
   pan_troglodytes = pan_troglodytes,
   canis_lupus = canis_lupus,
}

-- for 

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
