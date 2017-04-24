local class = require 'class'
local Color = require 'Color'
local Size = require 'Size'
local Sprite = require 'Sprite'
local Vec = require 'Vec'

local Tank = class('Tank', 'Sprite')

local width, height, _ = love.window.getMode()

function Tank:__init()
  self.super().__init(self)
  self.pos = Vec(width * 0.5, height)
  self.size = Size(width, height)
  self.color = Color(70, 164, 180)
  self.static = true
end

function Tank:update(dt)
end

function Tank:draw()
  Tank.super().draw(self)
end

return Tank
