local Entity = require 'Entity'

local UI = class('UI', 'Entity')

function UI:__init()
  UI.super().__init(self)
  self.static = true
end

function UI:draw()
  local player = self.scene:getEntitiesOfType('Player')[1]
  love.graphics.print('Score: '..player.score, 10, 10)
  local width, height, _ = love.window.getMode()
  if player.dead then
    local message = {
      { 255, 0, 0, 255 },
      'You were eaten!',
      { 255, 255, 255, 255 },
      'Press esc',
    }
    love.graphics.print(message, 10, height - 80, 0, 4, 4)
  end
  if player.score >= NUM_ENEMIES then
    local message = {
      { 0, 255, 0, 255 },
      'Nice!',
      { 255, 255, 255, 255 },
      'Close this stupid game'
    }
    love.graphics.print(message, 10, height - 80, 0, 3, 3)
  end

end

return UI
