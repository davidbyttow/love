local Vec = require 'Vec'

local Rect = class('Rect')

function Rect:__init(left, top, width, height)
  self.left = left or 0
  self.top = top or 0
  self.width = width or 0
  self.height = height or 0
end

function Rect:right()
  return self.left + self.width
end

function Rect:bottom()
  return self.top + self.height
end

function Rect:center()
  return Vec(self.left + self.width * 0.5, self.top + self.height * 0.5)
end

function Rect:overlaps(other)
	return self.left + self.width > other.left
    and self.left < other.left + other.width
    and self.top + self.height > other.top
    and self.top < other.top + other.height
end

return Rect
