local Color = require 'Color'
local Fish = require 'Fish'
local Sprite = require 'Sprite'
local Size = require 'Size'
local Vec = require 'Vec'

local Enemy = class('Enemy', 'Fish')

function Enemy:__init()
  Enemy.super().__init(self)
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
