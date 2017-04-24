local Color = require 'Color'
local Entity = require 'Entity'
local Sprite = require 'Sprite'
local Size = require 'Size'
local Vec = require 'Vec'

local Player = class('Player', 'Entity')

local SWIM_ACCEL = 500
local FLOW_PRESSURE = 10
local DRAG_MIN = 20
local HORIZONTAL_DRAG = 200
local TERMINAL_VELOCITY = 400

function Player:__init()
  Player.super().__init(self)
  self.color = Color(80, 0, 0)
  self.size = Size(40, 40)
  self.gravity = 0
  self._sprite = Sprite()
  self._sprite = Color(0, 0, 0)
end

function Player:load()
  self:addChild(self._sprite)
end

function Player:onKeyPress(key)
end

function Player:update(dt)
  if love.keyboard.isDown('right') then
    self.accel.x = SWIM_ACCEL
  elseif love.keyboard.isDown('left') then
    self.accel.x = -SWIM_ACCEL
  elseif love.keyboard.isDown('up') then
    self.accel.y = -SWIM_ACCEL
  elseif love.keyboard.isDown('down') then
    self.accel.y = SWIM_ACCEL
  else
    self.accel.x = 0
    self.accel.y = 0
  end

  local signs = self.vel:signs()

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
  self._sprite.draw()
end

return Player
