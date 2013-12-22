-- Main package that runs Scales
-- Coded by Hector Escobedo

require "scales"
require "scales_ui"
require "scales_data"
require "scales_mapper"
require "scales_entity"

local world = scales_mapper.world
local mapdraw = scales_mapper.mapdraw
local entity = scales_entity.entity
local clickable = scales_entity.clickable
local screen = scales_ui.screen
local state = scales.state

data = scales_data

local dragon = entity:new()
dragon = scales.gendragon(dragon)	-- Constructor for the table of attributes for the player's dragon

dragon.name = "Neirada"

local idprint = dragon.name .. " is a " .. dragon.colorscheme.maincolor .. " " .. dragon.sex .. " " .. dragon.breathtype .. " dragon."

local startmenu = clickable:new()

function startmenu.onclick ()
   state = "play"
end

-- print(idprint)

local vcam = scales_ui.vcam:new()

local bugprint = vcam.x .. " " .. vcam.y .. " " .. vcam.scale

local mousedown = false

local tiles = {}

local cacti = screen:new()

for c=1,3 do
   cacti[c] = entity:new()
end

local button = love.graphics.newImage("img/button.png")
love.graphics.setIcon(button)

local menuicon = entity:new()
menuicon:change_sprite(button)
menuicon.x = menuicon.width / 2
menuicon.y = menuicon.height / 2

local hud = screen:new()

local sleeping = false

function love.load ()
   love.keyboard.setKeyRepeat(true)
   love.graphics.setDefaultFilter("nearest", "nearest") -- Makes things sharper when zoomed in

   dragon:load_sprite("img/placeholder.png")
   dragon.x = 300
   dragon.y = 300

   startmenu:load_sprite("img/start.png")
   startmenu.x = 400
   startmenu.y = 250

   for c=1,#cacti do
      cacti[c]:load_sprite("img/cactus.png")
   end

   cacti[1].x = 40
   cacti[1].y = 120
   cacti[2].x = 80
   cacti[2].y = 10
   cacti[3].x = 230
   cacti[3].y = 200

   scales_mapper.loadtiles("img/tiles", world.tileindex, love.graphics.newImage, tiles)
   state = "start"
end

function love.draw ()

   if state == "play" then
      vcam:apply()
      mapdraw(world.levels[1], tiles, 32, love.graphics.draw)

      love.graphics.printf(idprint, 0, 400, 800, "center")

      cacti:render()

      dragon:render()
      vcam:clear()

      menuicon:render()
      love.graphics.printf(bugprint, 50, 10, 800, "center")
   elseif state == "start" then
      startmenu:render()
   end

end

function love.keypressed (k)
   -- Check for Ctrl commands
   if scales_ui.ctrlk("q") then
      love.event.quit()
   end

   if state == "play" then
      -- All other keys, using the argument
      if k == "=" then
	 vcam:zoom(.8)
      elseif k == "-" then
	 vcam:zoom(1.25)
      elseif k == "up" then
	 dragon:forward(10)
      elseif k == "down" then
	 dragon:backward(10)
      elseif k == "left" then
	 dragon.angle = dragon.angle - (math.pi / 10)
      elseif k == "right" then
	 dragon.angle = dragon.angle + (math.pi / 10)
      elseif k == "j" and world.levels[1].y > 0 then
	 world.levels[1].y = world.levels[1].y - 1
      elseif k == "k" and world.levels[1].y < #world.levels[1] then
	 world.levels[1].y = world.levels[1].y + 1
      elseif k == "l" and world.levels[1].x > 0 then
	 world.levels[1].x = world.levels[1].x - 1
      elseif k == "h" and world.levels[1].x < #world.levels[1][1] then
	 world.levels[1].x = world.levels[1].x + 1
      elseif k == "w" then
	 vcam:adjpan(0, -25)
      elseif k == "s" then
	 vcam:adjpan(0, 25)
      elseif k == "a" then
	 vcam:adjpan(-25, 0)
      elseif k == "d" then
	 vcam:adjpan(25, 0)
      elseif k == "v" then
	 if sleeping then
	    sleeping = false
	 else
	    sleeping = true
	 end
      elseif k == "1" then
	 vcam:setzoom(1)
      elseif k == "2" then
	 vcam:setzoom(.8)
      elseif k == "3" then
	 vcam:setzoom(.64)
      elseif k == "f11" then
	 love.graphics.toggleFullscreen()
      end
   else
      if k == "f11" then
	 love.graphics.toggleFullscreen()
      end
   end
end

function love.mousepressed ()
   mousedown = true
end

function love.mousereleased ()
   mousedown = false
end

function love.update (tick)
   if state == "play" then
      if mousedown then
	 vcam:setpos(vcam:posadjust(love.mouse.getX(),
				    love.mouse.getY()))
      end
      bugprint = vcam.x .. " " .. vcam.y .. " " .. vcam.scale ..
	 " " .. vcam.width .. " " .. vcam.height
   elseif state == "start" then
      startmenu:check()
   end

   if sleeping then
      scales_ui.fade(menuicon, 20)
      for c=1,#cacti do
	 scales_ui.fade(cacti[c], 1)
      end
   else
      menuicon.alpha = 255
      for c=1,#cacti do
	 cacti[c].alpha = 255
      end
   end
end
