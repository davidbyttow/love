require 'const'
class = require 'class'

function math.clamp(v, min, max)
  if v < min then
    v = min
  elseif v > max then
    v = max
  end
  return v
end
