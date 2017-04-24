local Color = require 'Color'
local Size = require 'Size'
local Sprite = require 'Sprite'
local Vec = require 'Vec'

local Player = class('Player', 'Sprite')

local SWIM_ACCEL = 200
local FLOW_PRESSURE = 10
local HORIZONTAL_DAMPING = 10

function Player:__init()
  Player.super().__init(self)
  self.color = Color(80, 0, 0)
  self.size = Size(40, 40)
  self.gravity = 0
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
end

return Player
