require "goal"
require "platform"
Object = require "classic"

local Level = Object:extend()

function Level:new(levelTable)
    self.type = "level"
    self.internalTable = levelTable
    self.platforms = {}
    self:setUp()
end

function Level:setUp()
    length = #self.internalTable
    for i, v in pairs(self.internalTable) do
        self.platforms[i] = Platform(v.x, v.y)
        if k == 1 then
            self.startingPlatform = self.platforms[i]
        end
        if i == length then
            self.finalPlatform = self.platforms[i]
        end
    end   
    self.goal = Goal(self.finalPlatform.x + 30, self.finalPlatform.y - 30)
end

function Level:draw()
    for k, v in pairs(self.platforms) do
        v:draw()
    end
    self.goal:draw()
end

function Level:clear()
    for i, v in pairs(self.platforms) do
        v:clear()
    end   
end


return Level