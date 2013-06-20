-- Main package that runs Scales
-- Coded by Hector Escobedo

require "scales"
require "scales_ui"
require "scales_data"

local dragon = scales.gendragon()	-- Constructor for the table of attributes for the player's dragon

dragon.name = "Neirada"

local idprint = dragon.name .. " is a " .. dragon.sex .. " " .. dragon.breathtype .. " dragon."

-- print(idprint)

function love.draw ()
   love.graphics.printf(idprint, 0, 400, 800, "center")
end

function love.update (tick)
   if scales_ui.ctrlk("q") then
      love.event.push("quit")
   end
end
