local Sprite = require 'Sprite'
local Vec = require('Vec')
local Size = require('Size')
local Player = class('Player', 'Sprite')

function Player:__init()
  Player.super().__init(self)
  self.size = Size(20, 20)
end

return Player
