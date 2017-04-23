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

return Rect
