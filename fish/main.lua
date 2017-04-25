-- Global definitions for use everywhere
require 'globals'

local Enemy = require 'Enemy'
local Player = require 'Player'
local Scene = require 'Scene'
local Size = require 'Size'
local Tank = require 'Tank'
local UI = require 'UI'
local Vec = require 'Vec'

local scene = Scene()
local tank = Tank()
local player = Player()
local ui = UI()

local NUM_QUADS = 10

--local SEED = 1
local SEED = os.time()

function generateEnemies(count)
  local tankBounds = tank:boundingBox()
  local quadSize = Size(tankBounds.width / NUM_QUADS,
    tankBounds.height / NUM_QUADS)
  local selected = {}
  for i = 4, 6 do
    for j = 4, 6 do
      local index = i * 10 + j
      selected[index] = true
    end
  end

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
    enemy:setSizeLevel( math.random(0, MAX_ENEMY_LEVEL))
    scene:insert(enemy, tank)
  end
end

function init()
  scene = Scene()
  tank = Tank()
  player = Player()
  ui = UI()

  scene:insert(tank)

  local tankBounds = tank:boundingBox()
  player.pos = tankBounds:center()
	scene:insert(player, tank)

  generateEnemies(NUM_ENEMIES)

  scene:insert(ui)

	scene:load()
  love.graphics.setBackgroundColor(255, 255, 255)
end

function love.load()
  math.randomseed(SEED)

  init()
end

local active = true

function love.keypressed(key)
  if not player.dead then
    player:onKeyPress(key)
  elseif key == 'escape' then
    init()
  end
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
