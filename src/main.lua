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
screen = scales_entity.screen
state = scales.state
data = scales_data

vcam = scales_ui.vcam:new()
-- vcam.lbound = 0
-- vcam.rbound = love.window.getWidth()
-- vcam.ubound = 0
-- vcam.dbound = love.window.getHeight()

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
   vcam.scale = 1
end

-- print(idprint)

local bugprint = vcam.x .. " " .. vcam.y .. " " .. vcam.scale

local mousedown = false

local cacti = screen:new()
cacti:init(3)

local buttondata = love.image.newImageData("img/button.png")
love.window.setIcon(buttondata)

hud.menuicon = entity:new()
hud.menuicon:change_sprite(love.graphics.newImage(buttondata))
hud.menuicon.x = hud.menuicon.width / 2
hud.menuicon.y = hud.menuicon.height / 2

function love.load ()
   love.keyboard.setKeyRepeat(true)
   love.graphics.setDefaultFilter("linear", "linear")

   startmenu:load_sprite("img/cuneiform-start-screen.png")
   startmenu.x = 0
   startmenu.y = 0

   love.graphics.setDefaultFilter("nearest", "nearest") -- Makes things sharper when zoomed in

   dragon:load_sprite("img/placeholder.png")
   dragon.x = 300
   dragon.y = 300

   vcam.scale = (startmenu.width / love.window.getWidth())
   vcam.x = (startmenu.x - (startmenu.width / 2))
   vcam.y = (startmenu.y - (startmenu.height / 2))

   cacti:methodcall("load_sprite", "img/cactus.png")

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
      cacti:methodcall("render")
      dragon:render()
      vcam:clear()

      hud:methodcall("render")
      love.graphics.printf(bugprint, 50, 10, 800, "center")
   elseif state == "start" then
      vcam:apply()
      startmenu:render()
      vcam:clear()
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
      -- The all-important key controller
      scales_ui.keycontrol(scales_ui.keymap, getfenv())

      vcam:setpos(vcam:posadjust(dragon.x, dragon.y))

      bugprint = vcam.x .. " " .. vcam.y .. " " .. vcam.scale ..
	 " " .. vcam.width .. " " .. vcam.height
   elseif state == "start" then
      startmenu:check()
   end

   if sleeping then
      hud:methodcall("fade", tick, .2)
      cacti:methodcall("fade", tick, 5)
   else
      hud:setattr("alpha", 255)
      cacti:setattr("alpha", 255)
   end
end
