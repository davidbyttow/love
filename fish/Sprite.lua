local Color = require 'Color'
local Size = require 'Size'

local Sprite = class('Sprite')

local DEFAULT_FPS = 12

function Sprite:__init(size)
  self.color = Color(255, 255, 255, 255)
  self.flipX = false
  self.flipY = false
  self._images = {}
  self._anims = {}
  self._defaultImage = nil
  self._activeAnim = nil
  self._animElapsed = 0
end

function Sprite:loadImage(file)
  if self._images[file] then
    return self._images[file]
  end
  local image = love.graphics.newImage(file)
  self._images[file] = image

  if not self._defaultImage then
    self._defaultImage = image
  end

  return image
end

function Sprite:loadAnim(file, name, column, size, frames, fps)
  local image = self:loadImage(file)
  local anim = {
    quads = {},
    frames = frames,
    fps = fps or 0,
    image = image,
    size = size
  }
  for i = 1, frames do
    anim.quads[i] = love.graphics.newQuad(column * size, size * (i-1), size, size, image:getDimensions())
  end
  self._anims[name] = anim
end

function Sprite:playAnim(name, fps)
  fps = fps or 0
  self._activeAnim = self._anims[name]
  self._animElapsed = 0
end

function Sprite:update(dt)
  self._animElapsed = self._animElapsed + dt
end

function Sprite:draw(pos, size)
  local left = pos.x - size.width * 0.5
  local top = pos.y - size.height * 0.5
  local anim = self._activeAnim

  local scaleX = 1
  if self.flipX then
    scaleX = -1
    left = left + size.width
  end
  local scaleY = 1
  if self.flipY then
    scaleY = -1
    left = left + size.height
  end

  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  if anim then
    local frame = math.ceil(math.fmod(self._animElapsed * anim.frames, anim.frames))
    local image = anim.image
    local sx = size.width / anim.size * scaleX
    local sy = size.height / anim.size * scaleY
    love.graphics.draw(image, anim.quads[frame], left, top, 0, sx, sy)
  elseif self._defaultImage then
    local sx = size.width / self._defaultImage:getWidth() * scaleX
    local sy = size.height / self._defaultImage:getHeight() * scaleY
    love.graphics.draw(self._defaultImage, left, top, 0, sx, sy)
  else
    love.graphics.rectangle('fill', left, top, size.width, size.height)
  end
end

return Sprite
