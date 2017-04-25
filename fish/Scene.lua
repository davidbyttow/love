local physics = require 'physics'

function safeCall(obj, name, ...)
  if obj and obj[name] then
    return obj[name](obj, ...)
  end
  return nil
end

function forEach(node, fn)
  fn(node.ref)
  for _, child in pairs(node._children) do
    forEach(child, fn)
  end
end

local Scene = class('Scene')

function Scene:__init()
  self._children = {}
  self._entities = {}
  self._nodeMap = {}
end

function Scene:forEachInGraph(fn)
  for _, child in pairs(self._children) do
    forEach(child, fn)
  end
end

function Scene:load()
  self:forEachInGraph(function(e)
    e:load()
  end)
end

function Scene:update(dt)
  local toRemove = {}
  self:forEachInGraph(function(e)
    if not e.dead then
      e:update(dt)
    end
    if e.dead then
      table.insert(toRemove, e)
    end
  end)
  for _, e in pairs(toRemove) do
    self:_removeEntity(e)
  end
  physics.update(self._entities, dt)
end

function Scene:draw()
  self:forEachInGraph(function(e)
    if e.active then
      e:draw()
    end
  end)
end

function Scene:getEntitiesOfType(type)
  return self._entities[type]
end

function Scene:_addEntity(entity)
  local type = entity:type()
  if not self._entities[type] then
    self._entities[type] = {}
  end
  table.insert(self._entities[type], entity)
  entity.scene = self
end

function Scene:_removeEntity(entity)
end

function Scene:insert(entity, parent)
  local node = {
    ref = entity,
    _children = {},
    parent = nil
  }
  if parent then
    local n = self._nodeMap[parent]
    node.parent = n
    table.insert(n._children, node)
  else
    table.insert(self._children, node)
  end
  self._nodeMap[entity] = node
  self:_addEntity(entity)
end

return Scene
