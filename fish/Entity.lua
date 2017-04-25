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

local nextId = 0

function Entity:__init()
  self.id = nextId
  nextId = nextId + 1

  self.mass = 1
  self.pos = Vec(0, 0)
  self.vel = Vec(0, 0)
  self.accel = Vec(0, 0)
  self.size = Rect(1, 1) -- I'm a pixel!
  self.static = false
  self.gravity = GRAVITY
  self.active = true
  self.physicsType = 0
  self.collisionMask = 0
end

function Entity:collidesWith(other)
  return bit.band(self.collisionMask, other.physicsType) > 0
end

function Entity:handleTouch(collision)
end

function Entity:kill()
  self.active = false
  self.dead = true
  self.static = true
end

function Entity:type()
  return self:class().name
end

function Entity:boundingBox()
  return Entity.toBoundingBox(self.pos, self.size)
end

return Entity
