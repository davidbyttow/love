-- Global definitions for use everywhere
require 'const'
class = require 'class'

local Scene = require 'Scene'
local Player = require 'Player'
local Vec = require 'Vec'

-- r = Rect:new(0, 0, 10, 100)
-- print(r:right)
--
-- active = false
-- gravity = 2000
-- posX = 200
-- posY = 0
-- velX = 0
-- velY = 80
-- jumping = false

-- walking_speed = 200
-- player_size = 20
-- floor_height = 20

-- width, height = love.graphics.getDimensions()
-- floor = height - floor_height

-- function playsound(sound)
-- 	sound:stop()
-- 	sound:rewind()
-- 	sound:play()
-- end

-- local Foo = class('Foo')
--
-- function Foo:__init()
-- 	print('foo', self)
-- end
--
-- local Bar = class('Bar', 'Foo')
--
-- function Bar:__init()
-- 	self.super().__init(self)
-- 	print('bar', self)
-- end
--
-- local foo = Foo()
-- print(foo:class())
-- print(foo:super())
--
-- local bar = Bar()
-- print(bar:class())
-- print(bar:super())

local scene = Scene()
local player = Player(200, 100)
player.pos = Vec(200, 100)

function love.load()
  love.graphics.setBackgroundColor(255, 255, 255)

	scene:insert(player)
	scene:load()
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

local active = true

function love.update(dt)
  if not active then
    return
  end

	scene:update(dt)

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
end

function love.draw()
	--
  -- love.graphics.setColor(100, 100, 100)
  -- love.graphics.rectangle('fill', 0, floor, width, floor_height)

	scene:draw(dt)
end

function love.focus(focused)
  active = focused
end
