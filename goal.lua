Object = require "classic"
world = require "world"
Goal = Object:extend()

local HIT_BOX_SCALE = 1.2

function Goal:new(x, y)
    self.type = 'goal'
    self.isGoal = true
	self.r = 20
	self.x = x
	self.y = y
    self.playerHasReached = false
    world:add(self, self.x, self.y, self.r * HIT_BOX_SCALE, self.r * HIT_BOX_SCALE)
end

function Goal:setPlayerHasReached(hasReached)
    if hasReached then
        world:remove(self)
    end
    self.playerHasReached = hasReached
end

function Goal:draw()
    if not self.playerHasReached then
            love.graphics.setColor(255, 255, 255)
            love.graphics.circle('fill', self.x, self.y, self.r)
            return
    end
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("YOU WIN!", self.x - self.r, self.y - self.r)
end
