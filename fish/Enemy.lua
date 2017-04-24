local Color = require 'Color'
local Entity = require 'Entity'
local Sprite = require 'Sprite'
local Size = require 'Size'
local Vec = require 'Vec'

local Enemy = class('Enemy', 'Entity')

local SWIM_ACCEL = 500
local FLOW_PRESSURE = 10
local DRAG_MIN = 20
local HORIZONTAL_DRAG = 200
local TERMINAL_VELOCITY = 400

function Enemy:__init()
  Enemy.super().__init(self)
  self.color = Color(80, 0, 0)
  self.size = Size(48, 48)
  self.gravity = 0
  self.physicsType = PhysicsType.ENEMY
  self.collisionMask = bit.bor(PhysicsType.ENEMY)
end

function Enemy:load()
  self._sprite = Sprite()
  self._sprite:loadAnim('assets/purple_fish.png', 'idle', 0, 96, 4, 4)
  self._sprite:playAnim('idle')
end

function Enemy:update(dt)
  self._sprite:update(dt)
end

function Enemy:draw()
  self._sprite:draw(self.pos, self.size)
end

return Enemy
