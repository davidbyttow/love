local Color = require 'Color'
local Entity = require 'Entity'
local Size = require 'Size'
local Sprite = require 'Sprite'
local Vec = require 'Vec'

local Tank = class('Tank', 'Entity')

local width, height, _ = love.window.getMode()

function Tank:__init()
  self.super().__init(self)
  self.pos = Vec(width * 0.5, height * 0.5)
  self.size = Size(width, height)
  self.static = true

  self._sprite = Sprite()
  self._sprite.color = Color(70, 164, 180)
end

function Tank:load()
end

function Tank:update(dt)
end

function Tank:draw()
  self._sprite:draw(self.pos, self.size)
end

return Tank
