local Vec = class('Vec')

function Vec:__init(x, y)
  self.x = x or 0
  self.y = y or 0
end

function Vec:signs()
  local v = Vec(0, 0)
  if self.x > 0 then
    v.x = 1
  elseif self.x < 0 then
    v.x = -1
  end
  if self.y > 0 then
    v.y = 1
  elseif self.y < 0 then
    v.y = -1
  end
  return v
end

return Vec
