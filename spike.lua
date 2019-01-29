Object = require "classic"
local world = require "world"

local Spike = Object:extend()

function Spike:new(x, y)
    self.type = "spike"
    self.isSpike = true
    self.x = x
    self.y = y
    self.w = 20
    self.h = 30
    world:add(self, self.x, self.y, self.w, self.h)
end

function Spike:draw()
    love.graphics.triangle("fill", self.x, self.y, self.w, self.h)
end

function Spike:clear()
    world:remove(self)
end


return Spike