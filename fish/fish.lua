local Size = require 'Size'

local fish = {}

local START_SIZE = 16
local STEP_SIZE = 8

function fish.setSizeLevel(fish, level)
  local size = START_SIZE + STEP_SIZE * level
  fish.size = Size(size, size)
end

return fish
