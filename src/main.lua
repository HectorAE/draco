-- Main package that runs Scales
-- Coded by Hector Escobedo

require "scales"
require "scales_ui"
require "scales_data"
require "scales_mapper"
require "scales_entity"

-- Globals
world = scales_mapper.world
mapdraw = scales_mapper.mapdraw
entity = scales_entity.entity
clickable = scales_entity.clickable
screen = scales_ui.screen
state = scales.state
data = scales_data

vcam = scales_ui.vcam:new()

tiles = {}

dragon = entity:new()
dragon = scales.gendragon(dragon)	-- Constructor for the table of attributes for the player's dragon
dragon.name = "Neirada"

idprint = dragon.name .. " is a " .. dragon.colorscheme.maincolor .. " " .. dragon.sex .. " " .. dragon.breathtype .. " dragon."

startmenu = clickable:new()

hud = screen:new()

sleeping = false
-- End of globals

function startmenu.onclick ()
   state = "play"
end

-- print(idprint)

local bugprint = vcam.x .. " " .. vcam.y .. " " .. vcam.scale

local mousedown = false

local cacti = screen:new()

for c=1,3 do
   cacti[c] = entity:new()
end

local buttondata = love.image.newImageData("img/button.png")
local button = love.graphics.newImage(buttondata)
love.window.setIcon(buttondata)

local menuicon = entity:new()
menuicon:change_sprite(button)
menuicon.x = menuicon.width / 2
menuicon.y = menuicon.height / 2

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

      -- The all-important key controller
      scales_ui.keycontrol(scales_ui.keymap, getfenv())

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
