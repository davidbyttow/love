local Color = require 'Color'
local Entity = require 'Entity'
local Sprite = require 'Sprite'
local Size = require 'Size'
local Vec = require 'Vec'
local fish = require 'fish'

local Enemy = class('Enemy', 'Entity')

function Enemy:__init()
  Enemy.super().__init(self)
  self.color = Color(80, 0, 0)
  self.gravity = 0
  self.physicsType = PhysicsType.ENEMY
  self.collisionMask = bit.bor(PhysicsType.ENEMY)
  fish.setSizeLevel(self, 0)
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
