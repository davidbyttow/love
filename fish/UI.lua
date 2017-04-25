local Entity = require 'Entity'

local UI = class('UI', 'Entity')

function UI:__init()
  UI.super().__init(self)
  self.static = true
end

function UI:draw()
  local player = self.scene:getEntitiesOfType('Player')[1]
  love.graphics.print('Score: '..player.score, 10, 10)
  if player.dead then
    local width, height, _ = love.window.getMode()
    local message = {
      { 255, 0, 0, 255 },
      'You were eaten'
    }
    love.graphics.print(message, 10, height - 80, 0, 5, 5)
  end
end

return UI
