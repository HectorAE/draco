-- Taxonomic class system for Scales
-- Coded by Hector Escobedo

local taxaranks = {
   [1] = "domain",
   [2] = "kingdom",
   [3] = "phylum",
   [4] = "class",
   [5] = "order",
   [6] = "family",
   [7] = "genus",
   [8] = "species",
}
local tr = taxaranks

-- Taxonomic class tree
local taxonomictree = {}
local tt = taxonomictree

-- Custom function for defining new taxa classes
local function new_taxon (name, parent)
   local nt = {}
   if parent == nil then
      nt.__index = nt
      nt.rankno = 1		-- Root taxon
      nt[tr[1]] = name
      tt[name] = nt
   else
      if parent.rankno >= #tr then
	 error("Tried to define a sub-" .. tr[#tr] .. " taxon", 2)
      else
	 nt.__index = nt
	 setmetatable(nt, parent)
	 nt.rankno = parent.rankno + 1
	 nt[tr[nt.rankno]] = name
	 if nt.rankno == 3 and nt.kingdom == "plantae" then
	       nt.division = name
	 end
	 parent[name] = nt
      end
   end
end

new_taxon("eukaryota")

-- Animals
new_taxon("animalia", tt.eukaryota)

tt.eukaryota.animalia.arms = 0
tt.eukaryota.animalia.eyes = 0
tt.eukaryota.animalia.fins = 0
tt.eukaryota.animalia.flippers = 0
tt.eukaryota.animalia.legs = 0
tt.eukaryota.animalia.wings = 0

new_taxon("chordata", tt.eukaryota.animalia)

new_taxon("mammalia", tt.eukaryota.animalia.chordata)

tt.eukaryota.animalia.chordata.mammalia.eyes = 2

new_taxon("primates", tt.eukaryota.animalia.chordata.mammalia)

tt.eukaryota.animalia.chordata.mammalia.primates.arms = 2
tt.eukaryota.animalia.chordata.mammalia.primates.fingers = 5
tt.eukaryota.animalia.chordata.mammalia.primates.legs = 2
tt.eukaryota.animalia.chordata.mammalia.primates.toes = 5

new_taxon("hominidae", tt.eukaryota.animalia.chordata.mammalia.primates)

new_taxon("homo", tt.eukaryota.animalia.chordata.mammalia.primates.hominidae)

new_taxon("sapiens", tt.eukaryota.animalia.chordata.mammalia.primates.hominidae.homo)

local homo_sapiens = tt.eukaryota.animalia.chordata.mammalia.primates.hominidae.homo.sapiens

homo_sapiens.name = {
   english = "human",
   english_pl = "humans",
}

new_taxon("pan", tt.eukaryota.animalia.chordata.mammalia.primates.hominidae)

new_taxon("troglodytes", tt.eukaryota.animalia.chordata.mammalia.primates.hominidae.pan)

local pan_troglodytes = tt.eukaryota.animalia.chordata.mammalia.primates.hominidae.pan.troglodytes

pan_troglodytes.name = {
   english = "chimpanzee",
   english_pl = "chimpanzees",
}

new_taxon("carnivora", tt.eukaryota.animalia.chordata.mammalia)

new_taxon("canidae", tt.eukaryota.animalia.chordata.mammalia.carnivora)

tt.eukaryota.animalia.chordata.mammalia.carnivora.canidae.legs = 4
tt.eukaryota.animalia.chordata.mammalia.carnivora.canidae.toes = 5

new_taxon("canis", tt.eukaryota.animalia.chordata.mammalia.carnivora.canidae)

new_taxon("lupus", tt.eukaryota.animalia.chordata.mammalia.carnivora.canidae.canis)

local canis_lupus = tt.eukaryota.animalia.chordata.mammalia.carnivora.canidae.canis.lupus

canis_lupus.name = {
   english = "grey wolf",
   english_pl = "grey wolves",
}

new_taxon("arthropoda", tt.eukaryota.animalia)

new_taxon("arachnida", tt.eukaryota.animalia.arthropoda)

tt.eukaryota.animalia.arthropoda.arachnida.legs = 8

new_taxon("araneae", tt.eukaryota.animalia.arthropoda.arachnida)

new_taxon("theraphosidae", tt.eukaryota.animalia.arthropoda.arachnida.araneae)

new_taxon("chaetopelma", tt.eukaryota.animalia.arthropoda.arachnida.araneae.theraphosidae)

new_taxon("altugkadirorum", tt.eukaryota.animalia.arthropoda.arachnida.araneae.theraphosidae.chaetopelma)

local chaetopelma_altugkadirorum = tt.eukaryota.animalia.arthropoda.arachnida.araneae.theraphosidae.chaetopelma.altugkadirorum

chaetopelma_altugkadirorum.name = {
   english = "pine stump burrowing tarantula",
   english_pl = "pine stump burrowing tarantulas",
}

-- Plants
new_taxon("plantae", tt.eukaryota)

new_taxon("marchantiophyta", tt.eukaryota.plantae)

new_taxon("marchantiopsida", tt.eukaryota.plantae.marchantiophyta)

new_taxon("marchantiales", tt.eukaryota.plantae.marchantiophyta.marchantiopsida)

new_taxon("marchantiaceae", tt.eukaryota.plantae.marchantiophyta.marchantiopsida.marchantiales)

new_taxon("marchantia", tt.eukaryota.plantae.marchantiophyta.marchantiopsida.marchantiales.marchantiaceae)

new_taxon("polymorpha", tt.eukaryota.plantae.marchantiophyta.marchantiopsida.marchantiales.marchantiaceae.marchantia)

local marchantia_polymorpha = tt.eukaryota.plantae.marchantiophyta.marchantiopsida.marchantiales.marchantiaceae.marchantia.polymorpha

marchantia_polymorpha.name = {
   english = "common liverwort",
   english_pl = "common liverworts",
}

new_taxon("magnoliophyta", tt.eukaryota.plantae)

new_taxon("liliopsida", tt.eukaryota.plantae.magnoliophyta)

new_taxon("arecales", tt.eukaryota.plantae.magnoliophyta.liliopsida)

new_taxon("arecaceae", tt.eukaryota.plantae.magnoliophyta.liliopsida.arecales)

new_taxon("cocos", tt.eukaryota.plantae.magnoliophyta.liliopsida.arecales.arecaceae)

new_taxon("nucifera", tt.eukaryota.plantae.magnoliophyta.liliopsida.arecales.arecaceae.cocos)

local cocos_nucifera = tt.eukaryota.plantae.magnoliophyta.liliopsida.arecales.arecaceae.cocos.nucifera

cocos_nucifera.name = {
   english = "coconut palm",
   english_pl = "coconut palms",
}

-- Fungi
new_taxon("fungi", tt.eukaryota)

new_taxon("basidiomycota", tt.eukaryota.fungi)

new_taxon("agaricomycetes", tt.eukaryota.fungi.basidiomycota)

new_taxon("agaricales", tt.eukaryota.fungi.basidiomycota.agaricomycetes)

new_taxon("amanitaceae", tt.eukaryota.fungi.basidiomycota.agaricomycetes.agaricales)

new_taxon("amanita", tt.eukaryota.fungi.basidiomycota.agaricomycetes.agaricales.amanitaceae)

new_taxon("muscaria", tt.eukaryota.fungi.basidiomycota.agaricomycetes.agaricales.amanitaceae.amanita)

local amanita_muscaria = tt.eukaryota.fungi.basidiomycota.agaricomycetes.agaricales.amanitaceae.amanita.muscaria

amanita_muscaria.name = {
   english = "fly agaric",
   english_pl = "fly agarics",
}

new_taxon("strophariaceae", tt.eukaryota.fungi.basidiomycota.agaricomycetes.agaricales)

new_taxon("psilocybe", tt.eukaryota.fungi.basidiomycota.agaricomycetes.agaricales.strophariaceae)

new_taxon("semilanceata", tt.eukaryota.fungi.basidiomycota.agaricomycetes.agaricales.strophariaceae.psilocybe)

local psilocybe_semilanceata = tt.eukaryota.fungi.basidiomycota.agaricomycetes.agaricales.strophariaceae.psilocybe.semilanceata

psilocybe_semilanceata.name = {
   english = "liberty cap",
   english_pl = "liberty caps",
}

-- Table of species for convenience
local species = {
   homo_sapiens = homo_sapiens,
   pan_troglodytes = pan_troglodytes,
   canis_lupus = canis_lupus,
   chaetopelma_altugkadirorum = chaetopelma_altugkadirorum,
   marchantia_polymorpha = marchantia_polymorpha,
   cocos_nucifera = cocos_nucifera,
   amanita_muscaria = amanita_muscaria,
   psilocybe_semilanceata = psilocybe_semilanceata,
}

local P = {			-- Our package table to export
   taxonomictree = taxonomictree,		-- Pub name = local name
   taxaranks = taxaranks,
   new_taxon = new_taxon,
   species = species,
}

-- Dynamic package name allocation for requires
-- Allocates the called filename to package

if _REQUIREDNAME == nil then
   scales_taxa = P			-- Default package name
else
   _G[_REQUIREDNAME] = P
end
