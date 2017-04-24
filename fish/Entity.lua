local Vec = require 'Vec'
local Rect = require 'Rect'

local Entity = class('Entity')

function Entity.toBoundingBox(pos, size)
  return Rect(
    pos.x - size.width * 0.5,
    pos.y - size.height * 0.5,
    size.width,
    size.height)
end

function Entity:__init()
  self.pos = Vec(0, 0)
  self.vel = Vec(0, 0)
  self.accel = Vec(0, 0)
  self.size = Rect(1, 1) -- I'm a pixel!
  self.static = false
  self.gravity = GRAVITY
  self.active = true
  self.collisionMask = 0
  self.scene = nil
end

function Entity:collidesWith(other)
  return bit.band(self.collisionMask, other.collisionMask) > 0
end

function Entity:type()
  return self:class().name
end

function Entity:boundingBox()
  return Entity.toBoundingBox(self.pos, self.size)
end

return Entity
