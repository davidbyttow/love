local Entity = require 'Entity'
local Vec = require 'Vec'

local physics = class('Physics')

function checkForCollision(e, aabb, other, collisions)
  local ch = false
  local cv = false
  local otherAabb = Entity.toBoundingBox(other.pos, other.size)
  if aabb:overlaps(otherAabb) then
    table.insert(collisions, e.id, {
      entity = e,
      other = other,
      horizontal = h,
      vertical = v,
      dir = (other.pos - e.pos):normal(),
    })
  end
  return ch, cv
end

function checkAgainstGroup(e, aabb, others, collisions)
  for _, other in pairs(others) do
    if e ~= other and other.active and e:collidesWith(other) then
      checkForCollision(e, aabb, other, collisions)
    end
  end
end

function simulate(e, entityMap, dt)
  if e.static or not e.active then
    return
  end

  -- Apply acceleration
  e.vel.x = e.vel.x + e.accel.x * dt
  e.vel.y = e.vel.y + (e.accel.y + e.gravity) * dt

  -- Simulate next position
  local nextPos = Vec(e.pos.x, e.pos.y)
  nextPos.x = nextPos.x + e.vel.x * dt
  nextPos.y = nextPos.y + e.vel.y * dt

  local nextAabb = Entity.toBoundingBox(nextPos, e.size)

  -- Gather collisions
  local collisions = {}
  local ch = false
  local cv = false
  for otherType, others in pairs(entityMap) do
    if otherType ~= 'Tank' then
      checkAgainstGroup(e, nextAabb, others, collisions)
    elseif bit.bor(e.collisionMask, PhysicsType.WALL) then
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

  -- Handle touch events
  for _, collision in pairs(collisions) do
    e:handleTouch(collision)
    if collision.ch then
      ch = true
    end
    if collision.cv then
      cv = true
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
