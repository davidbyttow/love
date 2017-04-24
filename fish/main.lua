-- Global definitions for use everywhere
require 'globals'

local Enemy = require 'Enemy'
local Player = require 'Player'
local Scene = require 'Scene'
local Size = require 'Size'
local Tank = require 'Tank'
local Vec = require 'Vec'

local scene = Scene()
local tank = Tank()
local player = Player()

local NUM_QUADS = 10
local NUM_ENEMIES = 1

function generateEnemies(count)
  local tankBounds = tank:boundingBox()
  local quadSize = Size(tankBounds.width / NUM_QUADS,
    tankBounds.height / NUM_QUADS)
  local selected = {}

  for i = 1, count do
    local enemy = Enemy()

    local index = -1
    while index < 0 or selected[index] do
      index = math.random(0, NUM_QUADS * NUM_QUADS - 1)
    end
    selected[index] = true

    local hi = index % NUM_QUADS
    local vi = math.floor(index / NUM_QUADS)

    local pos = Vec(
      tankBounds.left + hi * quadSize.width + quadSize.width * 0.5,
      tankBounds.top + vi * quadSize.height + quadSize.height * 0.5)
    enemy.pos = pos
    scene:insert(enemy, tank)
  end
end

function love.load()
  math.randomseed(os.time())

  scene:insert(tank)

  local tankBounds = tank:boundingBox()
  player.pos = tankBounds:center()
	scene:insert(player, tank)

  generateEnemies(NUM_ENEMIES)

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
