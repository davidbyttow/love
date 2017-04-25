local Entity = require 'Entity'
local Size = require 'Size'

local Fish = class('Fish', 'Entity')

local START_SIZE = 16
local STEP_SIZE = 8
local DRAG_MIN = 20
local HORIZONTAL_DRAG = 200
local TERMINAL_VELOCITY = 400

function Fish:__init()
  Fish.super().__init(self)
  self.gravity = 0
  self.facing = 1
  self.score = 0
  self.maxSpeed = TERMINAL_VELOCITY
  self.horizontalDrag = HORIZONTAL_DRAG
  self:setSizeLevel(0)
end

function Fish:setSizeLevel(level)
  local size = START_SIZE + STEP_SIZE * level
  self.size = Size(size, size)
  self.mass = level
  self.sizeLevel = level
end

function Fish:handleTouch(collision)
  local other = collision.other
  if self:type() ~= other:type() and self:canEat(collision.other) then
    self:eat(collision.other)
    self.score = self.score + 1
  end
end

function Fish:canEat(fish)
  local toFish = fish.pos - self.pos
  if (toFish.x < 0 and self.facing < 0) or (toFish.x > 0 and self.facing > 0) then
    if fish.mass < self.mass then
      return true
    end
  end
  return false
end

function Fish:eat(fish)
  fish.static = true
  fish.active = false
  fish.dead = true
  self:setSizeLevel(self.sizeLevel + 1)
  self._sprite:playAnim('eat', function()
    self._sprite:playAnim('idle')
  end)
end

function Fish:applyWaterDrag()
  if math.abs(self.accel.x) == 0 and math.abs(self.vel.x) > DRAG_MIN then
    if self.vel.x > 0 then
      self.accel.x = -self.horizontalDrag
    else
      self.accel.x = self.horizontalDrag
    end
  end

  if math.abs(self.vel.x) > self.maxSpeed then
    self.vel.x = math.clamp(self.vel.x, -self.maxSpeed, self.maxSpeed)
    self.accel.x = 0
  end
  if math.abs(self.vel.y) > self.maxSpeed then
    self.vel.y = math.clamp(self.vel.y, -self.maxSpeed, self.maxSpeed)
    self.accel.y = 0
  end
end

return Fish
