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

-- Custom function for defining new taxa classes
local function new_taxon (parent)
   local nt = {}
   if parent == nil then
      nt.__index = nt
      nt.rankno = 1		-- Root taxon
   else
      setmetatable(nt, {__index = parent})
      if parent.rankno < #trt then
	 nt.rankno = parent.rankno + 1
      else
	 error("tried to define a sub-" .. trt[#trt] ..
	       " taxon", 2) -- Not me! Them!
      end
   end

   nt.rank = trt[nt.rankno]

   return nt
end

-- Taxonomic class tree
local eukaryota = new_taxon()
eukaryota.domain = "eukaryota"

local animalia = new_taxon(eukaryota)
animalia.kingdom = "animalia"

animalia.arms = 0
animalia.eyes = 2
animalia.fins = 0
animalia.legs = 0
animalia.wings = 0

local chordata = new_taxon(animalia)
chordata.phylum = "chordata"

local mammalia = new_taxon(chordata)
mammalia.class = "mammalia"

local primates = new_taxon(mammalia)
primates.order = "primates"

primates.arms = 2
primates.legs = 2

local hominidae = new_taxon(primates)
hominidae.family = "hominidae"

local homo = new_taxon(hominidae)
homo.genus = "homo"

local homo_sapiens = new_taxon(homo)
homo_sapiens.species = "sapiens"

homo_sapiens.name = {
   english = "human",
   english_pl = "humans",
}

local pan = new_taxon(hominidae)
pan.genus = "pan"

local pan_troglodytes = new_taxon(pan)
pan_troglodytes.species = "troglodytes"

pan_troglodytes.name = {
   english = "chimpanzee",
   english_pl = "chimpanzees",
}

local carnivora = new_taxon(mammalia)
carnivora.order = "carnivora"

local canidae = new_taxon(carnivora)
canidae.family = "canidae"

canidae.legs = 4

local canis = new_taxon(canidae)
canis.genus = "canis"

local canis_lupus = new_taxon(canis)
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

local P = {			-- Our package table to export
   species = species,		-- Pub name = local name
   taxaranktable = taxaranktable,
   new_taxon = new_taxon,
}

-- Dynamic package name allocation for requires
-- Allocates the called filename to package

if _REQUIREDNAME == nil then
   scales_taxa = P			-- Default package name
else
   _G[_REQUIREDNAME] = P
end
