local class = require 'class'
local Entity = require 'Entity'

local Tank = class('Tank', 'Entity')

function Tank:__init()
  self.super().__init(self)
end

function Tank:draw()
  love.graphics.setBackgroundColor(70, 164, 180)
end

return Tank
