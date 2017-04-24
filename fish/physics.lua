local Entity = require 'Entity'
local Vec = require 'Vec'

local physics = class('Physics')

function checkForCollision(e, aabb, other)
  local ch = false
  local cv = false
  local otherAabb = Entity.toBoundingBox(other.pos, other.size)
  if aabb:overlaps(otherAabb) then
    ch = true
    cv = true
  end
  return ch, cv
end

function checkAgainstGroup(e, aabb, others)
  local ch = false
  local cv = false
  for _, other in pairs(others) do
    if e ~= other and other.active and e:collidesWith(other) then
      local h, v = checkForCollision(e, aabb, other)
      ch = h or ch
      cv = v or cv
    end
    if ch and cv then
      break
    end
  end
  return ch, cv
end

function simulate(e, entityMap, dt)
  if e.static or not e.active then
    return
  end

  local ch = false
  local cv = false

  -- Apply acceleration
  e.vel.x = e.vel.x + e.accel.x * dt
  e.vel.y = e.vel.y + (e.accel.y + e.gravity) * dt

  -- Simulate next position
  local nextPos = Vec(e.pos.x, e.pos.y)
  nextPos.x = nextPos.x + e.vel.x * dt
  nextPos.y = nextPos.y + e.vel.y * dt

  local nextAabb = Entity.toBoundingBox(nextPos, e.size)

  -- Check collisions
  for otherType, others in pairs(entityMap) do
    if otherType ~= 'Tank' then
      h, v = checkAgainstGroup(e, nextAabb, others)
      ch = h or ch
      cv = v or cv
    elseif e:type() == 'Player' then
      for _, tank in pairs(others) do
        local tankAabb = tank:boundingBox()
        if nextAabb.left < tankAabb.left or nextAabb:right() > tankAabb:right() then
          e.vel.x = -e.vel.x
          e.accel.x = -e.accel.x
          ch = true
        end
        if nextAabb.top < tankAabb.top or nextAabb:bottom() > tankAabb:bottom() then
          e.vel.y = 0
          e.accel.y = 0
          cv = true
        end
      end
    end
  end

  -- Update position based on collision factor
  if not ch then
    e.pos.x = nextPos.x
  end
  if not cv then
    e.pos.y = nextPos.y
  end
end

function physics.update(entityMap, dt)
  for type, entities in pairs(entityMap) do
    for _, entity in pairs(entities) do
      simulate(entity, entityMap, dt)
    end
  end
end

return physics
