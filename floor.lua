Object = require "classic"
world = require "world"
Floor = Object:extend()

local MAX_NUM_OF_JUMPING_FRAMES = 15


function Floor:new()
    self.type = 'floor'
    self.isFloor = true
	self.w = love.graphics.getWidth()
	self.h = love.graphics.getHeight()
	self.x = 0
	self.y = self.h / 2
    world:add(self, self.x, self.y, self.w, self.h)
end

function Floor:draw()
    love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end
