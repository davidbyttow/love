local Vec = class('Vec')

local function isVector(t)
  return class.type(t) == 'Vec'
end

function Vec:__init(x, y)
  self.x = x or 0
  self.y = y or 0
end

function Vec.__add(a, b)
  return Vec(a.x + b.x, a.y + b.y)
end

function Vec.__sub(a, b)
  return Vec(a.x - b.x, a.y - b.y)
end

function Vec.__mul(a, b)
  if type(a) == "number" and isVector(b) then
    return Vec(b.x * a, b.y * a)
  elseif type(b) == "number" and isVector(a) then
    return Vec(a.x * b, a.y * b)
  end
  error("Type mismatch: vector and number expected", 2)
end

function Vec.__unm(a)
	return Vec(-a.x, -a.y)
end

function Vec:__tostring()
	return "("..tonumber(self.x)..","..tonumber(self.y)..")"
end

function Vec:clone()
  return Vec(self.x, self.y)
end

function Vec:unpack()
  return self.x, self.y
end

function Vec:len()
  return math.sqrt(self:len2())
end

function Vec:len2()
  return self.x * self.x + self.y * self.y
end

function Vec.dist(a, b)
  return math.sqrt(Vec.dist2(a, b))
end

function Vec.dist2(a, b)
  local dx = a.x - b.x
  local dy = a.y - b.y
  return dx * dx + dy * dy
end

function Vec:normalize()
  local len = self:len()
  if len > 0 then
    self.x = self.x / len
    self.y = self.y / len
  end
  return self
end

function Vec:normal()
  return self:clone():normalize()
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
