local Entity = require 'Entity'
local Sprite = class('Sprite', 'Entity')

function Sprite:__init()
  Sprite.super().__init(self)
end

function Sprite:update(dt)
end

function Sprite:draw()
  local left = self.pos.x - self.size.width * 0.5
  local top = self.pos.y + self.size.height
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle('fill', left, top, self.size.width, self.size.height)
end
