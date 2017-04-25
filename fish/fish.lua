local Entity = require 'Entity'
local Size = require 'Size'

local Fish = class('Fish', 'Entity')

local START_SIZE = 16
local STEP_SIZE = 8

function Fish:__init()
  Fish.super().__init(self)
  self.gravity = 0
  self:setSizeLevel(0)
end

function Fish:setSizeLevel(level)
  local size = START_SIZE + STEP_SIZE * level
  self.size = Size(size, size)
  self.mass = level
  self.sizeLevel = level
end

function Fish:eat(fish)
  fish.static = true
  fish.active = false
  self:setSizeLevel(self.sizeLevel + 1)
end

return Fish
