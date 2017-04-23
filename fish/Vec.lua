local Vec = class('Vec')

function Vec:__init(x, y)
  self.x = x or 0
  self.y = y or 0
end

return Vec
