local Vec = require 'Vec'
local Rect = require 'Rect'

local Entity = class('Entity')

function Entity:__init()
  self.pos = Vec(0, 0)
  self.vel = Vec(0, 0)
  self.size = Rect(1, 1) -- I'm a pixel!
  self.static = false
  self.gravity = GRAVITY
end

return Entity
