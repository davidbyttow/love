local Color = require 'Color'
local Fish = require 'Fish'
local Sprite = require 'Sprite'
local Size = require 'Size'
local Vec = require 'Vec'
local Fish = require 'Fish'

local Player = class('Player', 'Fish')

local SWIM_ACCEL = 500
local FLOW_PRESSURE = 10

function Player:__init()
  Player.super().__init(self)
  self.physicsType = PhysicsType.PLAYER
  self.collisionMask = bit.bor(PhysicsType.ENEMY)
  self.facing = 1
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

function Player:update(dt)
  self._sprite:update(dt)

  if love.keyboard.isDown('right') then
    self.accel.x = SWIM_ACCEL
    self.facing = 1
  elseif love.keyboard.isDown('left') then
    self.accel.x = -SWIM_ACCEL
    self.facing = -1
  elseif love.keyboard.isDown('up') then
    self.accel.y = -SWIM_ACCEL
  elseif love.keyboard.isDown('down') then
    self.accel.y = SWIM_ACCEL
  else
    self.accel.x = 0
    self.accel.y = 0
  end

  self:applyWaterDrag()
end

function Player:draw()
  self._sprite.flipX = self.facing < 0
  self._sprite:draw(self.pos, self.size)
end

return Player
