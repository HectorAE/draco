-- Main package that runs Scales
-- Coded by Hector Escobedo

require "scales"
require "scales_ui"
require "scales_data"
require "scales_mapper"

local world = scales_mapper.world
local mapdraw = scales_mapper.mapdraw

data = scales_data

local dragon = scales.gendragon()	-- Constructor for the table of attributes for the player's dragon

dragon.name = "Neirada"

local idprint = dragon.name .. " is a " .. dragon.colorscheme.maincolor .. " " .. dragon.sex .. " " .. dragon.breathtype .. " dragon."

-- print(idprint)

local vcam = scales_ui.vcam

local bugprint = vcam.x .. " " .. vcam.y .. " " .. vcam.scale

local mousedown = false

local tiles = {}

function love.load ()
   picdragon = love.graphics.newImage("img/placeholder.png")
   button = love.graphics.newImage("img/button.png")
   scales_mapper.loadtiles("img/tiles", world.tileindex, love.graphics.newImage, tiles)
end

function love.draw ()
   vcam:apply()
   mapdraw(world.levels[1], tiles, 32, love.graphics.draw)

   love.graphics.printf(idprint, 0, 400, 800, "center")
   love.graphics.printf(bugprint, 0, 200, 800, "center")
   love.graphics.draw(picdragon, 300, 300)
   vcam:clear()

   love.graphics.draw(button, 0, 0)
end

function love.keypressed (k)
   -- Check for Ctrl commands
   if scales_ui.ctrlk("q") then
      love.event.quit()
   end

   -- All other keys, using the argument
   if k == "=" then
      vcam:zoom(.5)
   elseif k == "-" then
      vcam:zoom(2)
   elseif k == "up" and world.levels[1].y > 0 then
      world.levels[1].y = world.levels[1].y - 1
   elseif k == "down" and world.levels[1].y < #world.levels[1] then
      world.levels[1].y = world.levels[1].y + 1
   elseif k == "left" and world.levels[1].x > 0 then
      world.levels[1].x = world.levels[1].x - 1
   elseif k == "right" and world.levels[1].x < #world.levels[1][1] then
      world.levels[1].x = world.levels[1].x + 1
   elseif k == "f11" then
      love.graphics.toggleFullscreen()
   end
end

function love.mousepressed()
   mousedown = true
end

function love.mousereleased()
   mousedown = false
end

function love.update (tick)
   if mousedown then
      vcam:setpos(vcam:posadjust(love.mouse.getX(), love.mouse.getY()))
   end
   bugprint = vcam.x .. " " .. vcam.y .. " " .. vcam.scale
end
