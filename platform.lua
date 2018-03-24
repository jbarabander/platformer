Object = require "classic"
world = require "world"
Platform = Object:extend()

function Platform:new(x, y)
    self.type = 'platform'
    self.isPlatform = true
	self.w = 60
	self.h = 20
	self.x = x
	self.y = y
    world:add(self, self.x, self.y, self.w, self.h)
end

function Platform:clear()
	world:remove(self)
end

function Platform:draw()
    love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end
