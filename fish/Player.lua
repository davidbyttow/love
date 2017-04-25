local Color = require 'Color'
local Fish = require 'Fish'
local Sprite = require 'Sprite'
local Size = require 'Size'
local Vec = require 'Vec'
local Fish = require 'Fish'

local Player = class('Player', 'Fish')

local SWIM_ACCEL = 500
local FLOW_PRESSURE = 10
local DRAG_MIN = 20
local HORIZONTAL_DRAG = 200
local TERMINAL_VELOCITY = 400

function Player:__init()
  Player.super().__init(self)
  self.physicsType = PhysicsType.PLAYER
  self.collisionMask = bit.bor(PhysicsType.ENEMY)
  self._facing = 1
  self:setSizeLevel(6)
end

function Player:load()
  self._sprite = Sprite()
  self._sprite:loadAnim('assets/red_fish-idle.png', 'idle', 0, 96, 4, 4)
  self._sprite:loadAnim('assets/red_fish-eat.png', 'eat', 0, 96, 6, 24)
  self._sprite:playAnim('idle')
end

function Player:onKeyPress(key)
end

function Player:handleTouch(collision)
  local other = collision.other
  local toOther = other.pos - self.pos
  local handled = false
  if (toOther.x < 0 and self._facing < 0) or (toOther.x > 0 and self._facing > 0) then
    if other.mass < self.mass then
      self:eat(other)
      self._sprite:playAnim('eat', function()
        self._sprite:playAnim('idle')
      end)
      handled = true
    end
  else
  end

  if not handled then
    collision.other.vel = self.vel * 0.5
    self.vel = self.vel * -0.5
  end
end

function Player:update(dt)
  self._sprite:update(dt)

  for _, enemy in pairs(self.scene:getEntitiesOfType('Enemy')) do
    --fish.canEat(self, enemy)
  end

  if love.keyboard.isDown('right') then
    self.accel.x = SWIM_ACCEL
    self._facing = 1
  elseif love.keyboard.isDown('left') then
    self.accel.x = -SWIM_ACCEL
    self._facing = -1
  elseif love.keyboard.isDown('up') then
    self.accel.y = -SWIM_ACCEL
  elseif love.keyboard.isDown('down') then
    self.accel.y = SWIM_ACCEL
  else
    self.accel.x = 0
    self.accel.y = 0
  end

  local signs = self.vel:signs()

  self._sprite.flipX = self._facing < 0

  if math.abs(self.accel.x) == 0 and math.abs(self.vel.x) > DRAG_MIN then
    if self.vel.x > 0 then
      self.accel.x = -HORIZONTAL_DRAG
    else
      self.accel.x = HORIZONTAL_DRAG
    end
  end

  if math.abs(self.vel.x) > TERMINAL_VELOCITY then
    self.vel.x = math.clamp(self.vel.x, -TERMINAL_VELOCITY, TERMINAL_VELOCITY)
    self.accel.x = 0
  end
  if math.abs(self.vel.y) > TERMINAL_VELOCITY then
    self.vel.y = math.clamp(self.vel.y, -TERMINAL_VELOCITY, TERMINAL_VELOCITY)
    self.accel.y = 0
  end
end

function Player:draw()
  self._sprite:draw(self.pos, self.size)
end

return Player
