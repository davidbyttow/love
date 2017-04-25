local Color = require 'Color'
local Fish = require 'Fish'
local Sprite = require 'Sprite'
local Size = require 'Size'
local Vec = require 'Vec'

local Enemy = class('Enemy', 'Fish')

local SWIM_ACCEL = 300

function Enemy:__init()
  Enemy.super().__init(self)
  self.physicsType = PhysicsType.ENEMY
  self.collisionMask = bit.bor(PhysicsType.ENEMY)
  self._findTargetTimer = 0
end

function Enemy:load()
  self._sprite = Sprite()
  self._sprite:loadAnim('assets/purple_fish.png', 'idle', 0, 96, 4, 4)
  self._sprite:loadAnim('assets/purple_fish-eat.png', 'eat', 0, 96, 6, 24)
  self._sprite:playAnim('idle')

  self:findTarget()
end

function Enemy:findTarget()
  if math.random(100) > 30 then
    local player = self.scene:getEntitiesOfType('Player')[1]
    self._target = player.pos
  else
    local tank = self.scene:getEntitiesOfType('Tank')[1]
    local bound = tank:boundingBox()
    self._target = Vec(math.random(0, bound.width), math.random(0, bound.height))
  end
  self._findTargetTimer = math.random(3, 6)
end

function Enemy:update(dt)
  self._sprite:update(dt)

  if self._findTargetTimer < 0 then
    self:findTarget()
  end

  local toTarget = self._target - self.pos
  if toTarget.x > 0 then
    self.facing = 1
  else
    self.facing = -1
  end

  if toTarget:len() < self.size.width + 20 then
    self:findTarget()
  end

  if toTarget.x > 10 then
    self.accel.x = SWIM_ACCEL
    self.facing = 1
  elseif toTarget.x < -10 then
    self.accel.x = -SWIM_ACCEL
    self.facing = -1
  elseif toTarget.y > 10 then
    self.accel.y = SWIM_ACCEL
  elseif toTarget.y < -10 then
    self.accel.y = -SWIM_ACCEL
  else
    self.accel.x = 0
    self.accel.y = 0
  end

  self:applyWaterDrag()
end

function Enemy:draw()
  self._sprite.flipX = self.facing < 0
  self._sprite:draw(self.pos, self.size)
end

return Enemy
