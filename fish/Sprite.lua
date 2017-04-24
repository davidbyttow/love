local Color = require 'Color'
local Entity = require 'Entity'

local Sprite = class('Sprite', 'Entity')

function Sprite:__init()
  Sprite.super().__init(self)
  self.color = Color(0, 0, 0, 255)
end

function Sprite:draw()
  local rect = self:boundingBox()
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  love.graphics.rectangle('fill', rect.left, rect.top, rect.width, rect.height)
end
