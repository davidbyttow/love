local Size = class('Size')

function Size:__init(width, height)
  self.width = width or 0
  self.height = height or 0
end

return Size
