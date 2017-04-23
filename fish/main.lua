-- Global definitions for use everywhere
require 'const'
class = require 'class'

local shaders = require 'shaders'

local Scene = require 'Scene'
local Tank = require 'Tank'
local Player = require 'Player'
local Vec = require 'Vec'

local scene = Scene()
local tank = Tank()
local player = Player(200, 100)
player.pos = Vec(200, 100)

function love.load()
  scene:insert(tank)
	scene:insert(player, tank)

	scene:load()

  love.graphics.setBackgroundColor(255, 255, 255)

  local grain = shaders.filmgrain()  
  grain.opacity = 0.2

  local water = shaders.water()
  post_effect = water
end


local active = true
local time = 0

function love.update(dt)
  if not active then
    return
  end

  time = time + dt

	scene:update(dt)
end

function love.draw()
  post_effect.time = time
  post_effect:draw(function()
    scene:draw(dt)
  end)
end

function love.focus(focused)
  active = focused
end

-- function love.keypressed(key)
--   if key == 'up' then
--     if not jumping then
--       playsound(jump_sound)
--       jumping = true
--       velY = -800
--       if love.keyboard.isDown('right') then
--         velX = velX + 200
--       elseif love.keyboard.isDown('left') then
--         velX = velX - 200
--       end
--     end
--   end
-- end

  -- dt = math.min(0.01666667, dt)
  -- if not jumping then
  --   if love.keyboard.isDown('right') then
  --     velX = walking_speed
  --   elseif love.keyboard.isDown('left') then
  --     velX = -walking_speed
  --   else
  --     velX = 0
  --   end
  -- end
  --
  -- velY = velY + gravity * dt
  --
  -- posX = posX + velX * dt
  -- posY = posY + velY * dt
  --
  -- if posX <= 0 then
  --   velX = 0
  --   posX = 0
  -- elseif posX + player_size > width then
  --   velX = 0
  --   posX = width - player_size
  -- end
  --
  -- if posY + player_size >= floor then
  --   posY = floor - player_size
  --   velY = 0
  --   jumping = false
  -- end
