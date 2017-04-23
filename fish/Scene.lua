local physics = require 'physics'
local class = require 'class'

function safeCall(obj, name, ...)
  if obj and obj[name] then
    return obj[name](obj, ...)
  end
  return nil
end

function callTree(root, name, ...)
  safeCall(root.ref, name, ...)
  for _, child in pairs(root.children) do
    callTree(child, name, ...)
  end
end

local Scene = class('Scene')

function Scene:__init()
  self.children = {}
  self._entities = {}
  self._nodeMap = {}
end

function Scene:load()
  callTree(self, 'load')
end

function Scene:update(dt)
  callTree(self, 'update', dt)
  physics.update(self._entities, dt)
end

function Scene:draw()
  callTree(self, 'draw')
end

function Scene:addEntity(entity)
  local type = entity:class().name
  if not self._entities[type] then
    self._entities[type] = {}
  end
  table.insert(self._entities[type], entity)
end

function Scene:insert(entity, parent)
  local node = {
    ref = entity,
    children = {},
    parent = nil
  }
  if parent then
    local n = self._nodeMap[parent]
    node.parent = n
    table.insert(n.children, node)
  else
    table.insert(self.children, node)
  end
  self._nodeMap[entity] = node
  self:addEntity(entity)
end

return Scene
