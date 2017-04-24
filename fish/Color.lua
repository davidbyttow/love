local class = require 'class'

local Color = class('Color')

function Color:__init(r, g, b, a)
  self.r = r or 0
  self.g = g or 0
  self.b = b or 0
  self.a = a or 255
end

return Color
