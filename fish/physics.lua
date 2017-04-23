local physics = class('Physics')

function updateEntity(e, dt)
  e.vel.y = e.vel.y + e.gravity * dt
  e.pos.x = e.pos.x + e.vel.x * dt
  e.pos.y = e.pos.y + e.vel.y * dt
end

function physics.update(entityMap, dt)
  for type, entities in pairs(entityMap) do
    for _, entity in pairs(entities) do
      updateEntity(entity, dt)
    end
  end
end

return physics
