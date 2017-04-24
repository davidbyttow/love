local Color = require 'Color'

local Sprite = class('Sprite', 'Entity')

function Sprite:__init()
  self.color = Color(0, 0, 0, 255)
end

function Sprite:update(dt)
end

function Sprite:draw()
  local rect = self:boundingBox()
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  love.graphics.rectangle('fill', rect.left, rect.top, rect.width, rect.height)
end

return Sprite
