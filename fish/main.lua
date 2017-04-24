-- Global definitions for use everywhere
require 'const'
class = require 'class'

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
end

local active = true

function love.keypressed(key)
  player:onKeyPress(key)
end

function love.update(dt)
  if not active then
    return
  end
  dt = math.min(0.01666667, dt)
	scene:update(dt)
end

function love.draw()
  scene:draw(dt)
end

function love.focus(focused)
  active = focused
end
